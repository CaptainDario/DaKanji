##########################################
#  
# This script removes empty translations from the localization files.
# It also generates the dart files for the localization.
#
##########################################


import os
import subprocess


if __name__ == "__main__":


	# run the dart commands to generate the dart localizations files
	shared_args = ["flutter", "pub", "run", "easy_localization:generate", "-S", "assets/translations/", "-O", "./lib", "-o",]

	subprocess.call([*shared_args, "locales_keys.dart", "-f", "keys"], shell=True)
	subprocess.call([*shared_args, "CodegenLoader.dart", "-f", "json"], shell=True)


	path = os.path.join(os.getcwd(), "lib", "CodegenLoader.dart")

	f = []
	with open(path, encoding="utf8", mode="r") as file:
		f = file.readlines()
		
		# remove all lines which have empty translations
		for cnt, line in enumerate(f):
			if (': ""' in line):
				del f[cnt]
	
	# save the files back to disk
	with open(path, encoding="utf8", mode="w+") as file:
		file.write("".join(f))


