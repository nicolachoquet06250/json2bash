package main

import (
	"encoding/json"
	"flag"
	"fmt"
	"io"
	"log"
	"net/http"
	"os"
	"os/exec"
	"reflect"
	"strings"
)

type DynamicJsonObject = map[string]any
type DynamicJsonArray = []map[string]any

func convertJsonToBashArray(input string) string {
	var arr DynamicJsonArray
	var obj DynamicJsonObject

	var convertJsonObjectToBash = func(obj DynamicJsonObject, inStr ...bool) string {
		if len(inStr) == 0 {
			inStr = append(inStr, false)
		}

		outStr := ""
		for k, v := range obj {
			if v != nil {
				if reflect.TypeOf(v).Name() == "string" {
					if inStr[0] {
						v = fmt.Sprintf("\\\\\\\"%v\\\\\\\"", v)
					} else {
						v = fmt.Sprintf("\\\"%v\\\"", v)
					}
				}
				if reflect.TypeOf(v).Name() == "boolean" || reflect.TypeOf(v).Name() == "bool" {
					if fmt.Sprintf("%v", v) == "true" {
						v = 1
					} else {
						v = 0
					}
				}
			} else {
				v = ""
			}
			outStr = outStr + fmt.Sprintf("['%v']=%v ", k, v)
		}

		return outStr
	}

	outStr := "("

	if input[0:1] == "[" {
		if err := json.Unmarshal([]byte(input), &arr); err != nil {
			log.Fatal(err)
		}
	} else {
		if err := json.Unmarshal([]byte(input), &obj); err != nil {
			log.Fatal(err)
		}
	}

	if obj != nil {
		outStr = outStr + convertJsonObjectToBash(obj)
	} else if arr != nil {
		for _, _obj := range arr {
			outStr = outStr + "\\\"( " + convertJsonObjectToBash(_obj, true) + ")\\\" "
		}
	}

	outStr = outStr + ")"

	return outStr
}

func main() {
	_input := flag.String(
		"json",
		"",
		"Specify the json file url or local path (from file://) ou Specify the json content",
	)

	flag.Parse()

	isUrl := false
	isContent := false

	var input = *_input

	if input[0:1] == "[" || input[0:1] == "{" {
		isContent = true
	} else if strings.Contains(input, "file://") ||
		strings.Contains(input, "http://") ||
		strings.Contains(input, "https://") {
		isUrl = true
	}

	var f, _ = os.Create("cmd.sh")
	defer f.Close()

	outStr := ""

	if isContent {
		outStr = convertJsonToBashArray(input)
	} else if isUrl {
		var c []byte
		if strings.HasPrefix(input, "file:") {
			path := input[len("file://"):]

			c, _ = os.ReadFile(path)
		} else {
			res, err := http.Get(input)
			if err != nil {
				fmt.Printf("error making http request: %s\n", err)
				os.Exit(1)
			}

			c, _ = io.ReadAll(res.Body)
		}

		outStr = convertJsonToBashArray(string(c))
	}

	if outStr != "" {
		_, _ = f.Write([]byte("#!/bin/bash \n\n echo \"" + outStr + "\""))

		cmd := exec.Command("bash", "./cmd.sh")
		out, err := cmd.Output()
		if err != nil {
			fmt.Println(fmt.Errorf("%s", err))
		}

		fmt.Println(string(out))

		_ = os.Remove("cmd.sh")
	}
}
