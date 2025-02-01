CppApplication {
    qbs.profile: "iar8051"
    condition: {
        if (!qbs.architecture.contains("mcs51"))
            return false;
        return qbs.toolchain.contains("iar")
    }
    cpp.cLanguageVersion: "c99"


    Properties {
        condition: qbs.toolchain.contains("iar")
        cpp.includePaths: [
            "src",
            cpp.toolchainInstallPath + "/../inc/",
            cpp.toolchainInstallPath + "/../inc/clib",
            cpp.toolchainInstallPath + "/../lib/libmf/include/"]
        cpp.commonCompilerFlags: [
			"--dptr=1,16,separate",
			"--core=plain",
			"--place_constants=code",
			"--data_model=small",
			"--code_model=near",
			"--clib",
			"-e",
			"--calling_convention=idata_reentrant",
			"-DMASTER",
			"-D__DATA_MODEL__=1",
			"-D__CALLING_CONVENTION__=2"]
        cpp.entryPoint: "__program_start"
        cpp.driverLinkerFlags: [
            "-Fubrof",
			"-D_PDATA_STACK_SIZE=0x80",
			"-D_XDATA_STACK_SIZE=0xFFF",
			"-D_IDATA_STACK_SIZE=0x80",
			"-D_EXTENDED_STACK_START=0x00",
			"-D_EXTENDED_STACK_END=0x00",
			"-D_EXTENDED_STACK_SIZE=0x00",
			"-D_NR_OF_VIRTUAL_REGISTERS=8",
			"-D_CODEBANK_START=0",
			"-D_CODEBANK_END=0",
			"-D_XDATA_HEAP_SIZE=0xff",
			"-D_FAR_HEAP_SIZE=0xfff",
			"-D_HUGE_HEAP_SIZE=0xfff",
			"-D_FAR22_HEAP_SIZE=0xfff",
			"-D?PBANK=0xD9",
			"-xe",
			"-xm",
			"-xs",
			"-xo",
			"-Ointel-standard"]
        cpp.staticLibraries: [
            cpp.toolchainInstallPath + "/../lib/clib/cl-pli-nsic-1e16x01",
            cpp.toolchainInstallPath + "/../lib/libmf/iar/libmf-pli-nsic-1e16x01"]
    }
    
    Group {
        condition: qbs.toolchain.contains("iar")
        name: "IAR"
        prefix: "iar/"
        Group {
            name: "Linker Script"
            prefix: cpp.toolchainInstallPath + "/../config/devices/On Semiconductor/"
            fileTags: ["linkerscript"]
            // Explicitly use the default linker scripts for current target.
            files: ["lnk51ew_AX8052F143.xcl"]
        }
    }


    files: [
        "src/**.c", "src/**.h"]
}

    
