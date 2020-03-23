exec = a.out
sources = $(wildcard src/*.c)
sources += $(wildcard GL/src/*.c)
objects = $(sources:.c=.o)
flags = -Wall -g -IGL/include -lglfw -ldl -lcglm -lm


$(exec): $(objects)
	gcc $(objects) $(flags) -o $(exec)

%.o: %.c ../include/glad/%.h
	gcc -c $(flags) $< -o $@

%.o: %.c ../include/%.h
	gcc -c $(flags) $< -o $@

%.o: %.c include/%.h
	gcc -c $(flags) $< -o $@

glad:
	if [ ! -d GL ]; then ( pip install --upgrade git+https://github.com/dav1dde/glad.git#egg=glad && glad --generator=c --extensions=GL_EXT_framebuffer_multisample,GL_EXT_texture_filter_anisotropic --out-path=GL ) fi

clean:
	-rm *.out
	-rm *.o
	-rm src/*.o
