package main

import (
	"os"
	"strings"
)

func main() {
	_, in_conda_env := os.LookupEnv("CONDA_PREFIX")

	if in_conda_env {
		os.Exit(1)
	}

	user_home, err := os.UserHomeDir()

	if err != nil {
		println("Failed to get user home directory")
		os.Exit(1)
	}

	cwd, err := os.Getwd()

	if err != nil {
		println("Failed to get current working directory")
		os.Exit(1)
	}

	conda_home := user_home + "/miniconda3"
	conda_envs, err := os.ReadDir(conda_home + "/envs")

	if err != nil {
		println("Failed to read conda environments")
		os.Exit(1)
	}

	env_availables := false
	folder_split := strings.Split(cwd, "/")
	folder_name := folder_split[len(folder_split)-1]

	for _, env := range conda_envs {
		if env.IsDir() {
			base_name := env.Name()
			base_name_with_env := base_name + "_env"
			if folder_name == base_name || folder_name == base_name_with_env {
				env_availables = true
				break
			}
		}
	}

	if env_availables {
		os.Exit(0)
	} else {
		os.Exit(1)
	}
}
