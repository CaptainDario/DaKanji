import subprocess



if __name__ == "__main__":
    # on boarding pages
    for i in [1, 2, 3, 4]:
        # svg per page
        for j in [1, 2]:
            print(f"creating assets/images/onboarding/onboarding_{i}_{j}.vec")
            subprocess.run(
                "dart run vector_graphics_compiler " + 
                f"-i assets/images/onboarding/onboarding_{i}_{j}.svg " +
                f"-o assets/images/onboarding/onboarding_{i}_{j}.vec",
                shell=True
            )