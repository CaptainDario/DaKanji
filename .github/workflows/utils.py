import os


def set_github_env(name : str, value : str):
    """ Creates a github actions environment variable

    Args:
        name (str): the name of the varaible
        value (str): the value of the variable
    """

    env_file = os.getenv('GITHUB_ENV')

    with open(env_file, "a") as myfile:
        myfile.write(f"{name}={value}")