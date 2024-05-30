#include <stdio.h>
#include "neurala/api/c/inspectorlib.h"

int test_load_free_brain() {

	char *model_path = "D:\\Back_v2.zip";
	printf("Loading Model: %s\n", model_path);
	neurala_brain* brain;
	neurala_error_code code = neurala_create_brain_from_path(model_path, &brain);
	if (code == NEURALA_ERRC_OK) {
		printf("Model loaded sucessfully: %s\n", model_path);
		neurala_free_brain(brain);
	}
	else {
		printf("Error loading model: %i\n", code);
	}

	return 0;
}