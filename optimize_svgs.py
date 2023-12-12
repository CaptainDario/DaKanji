import subprocess



if __name__ == "__main__":
    for i in range(1, 4):
        for j in range(1, 3):
            subprocess.run(
                "dart run vector_graphics_compiler " + 
                f"-i assets/images/onboarding/onboarding_{i}_{j}.svg " +
                f"-o assets/images/onboarding/onboarding_{i}_{j}.vec",
                shell=True
            )