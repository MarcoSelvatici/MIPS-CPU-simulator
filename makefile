# Build Directory: folder with the object files.
BUILD_DIR := build
# Source Directory: folder with the source files.
SOURCE_DIR := src

# Path to the MIPS binary to execute.
BINARY_PATH := test_binaries/merge_sort.mips.bin

simulator: cleanup_build ${BUILD_DIR}/util.o ${BUILD_DIR}/context.o ${BUILD_DIR}/memory.o ${BUILD_DIR}/instruction_set.o ${BUILD_DIR}/mips_simulator.o ${BUILD_DIR}/main.o
	rm -f bin/mips_simulator
	g++ -O3 -std=c++11 \
	${BUILD_DIR}/util.o \
	${BUILD_DIR}/context.o \
	${BUILD_DIR}/memory.o \
	${BUILD_DIR}/instruction_set.o \
	${BUILD_DIR}/mips_simulator.o \
	${BUILD_DIR}/main.o \
	-o bin/mips_simulator

${BUILD_DIR}/%.o: ${SOURCE_DIR}/%.cpp ${BUILD_DIR}/
ifdef DEBUG
	g++ -D_DEBUG -c -O3 -std=c++11 -o $@ $<
else
	g++ -c -O3 -std=c++11 -o $@ $<
endif

cleanup_build:
	rm -r -f ${BUILD_DIR}
	mkdir -p ${BUILD_DIR}

run: simulator
	@# Expected exit code is 100.
	@./bin/mips_simulator ${BINARY_PATH} || ([ $$? -eq 100 ] && echo "Success" || echo "Failure")

test: simulator
	bin/mips_testbench bin/mips_simulator

clean:
	rm -f bin/mips_simulator
	rm -r -f ${BUILD_DIR}
	rm -f test/temp/*
