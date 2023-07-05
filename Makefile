LIBFLAGS := -lraylib -lpthread -lGL -lm -ldl -lgbm -ldrm -lEGL

SOURCES := shapes_basic_shapes.c

raylib-demo: $(SOURCES)
	@rm -f $@
	g++ $(SOURCES) -o $@ $(LIBFLAGS)
