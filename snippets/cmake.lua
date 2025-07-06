return {
	s("cmake", {
		t({
			"cmake_minimum_required(VERSION 3.5)",
			"project(",
		}),
		i(1, "PROJECT"),
		t({
			")",
			"file(GLOB_RECURSE sources src/*.cpp)",
			"",
			"add_executable(",
		}),
		l(l._1, 1),
		t({
			" ${sources})",
			"target_compile_options(",
		}),
		l(l._1, 1),
		t({
			" PUBLIC -Wall -Wextra -Werror -pedantic -std=c++20)",
		}),
	}),
}
