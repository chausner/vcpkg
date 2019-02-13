include(vcpkg_common_functions)

vcpkg_from_github(
    OUT_SOURCE_PATH SOURCE_PATH
    REPO sccn/liblsl
    REF 1.12
    SHA512 a67fbec22378259860528f21985cc597f8c17041e85592590fb32f7c20a1b09e0f5e38a15560e9e587dd4340278dda3fbeb29ec611f23841112fe6fab5b857c6
    HEAD_REF master
	PATCHES install-targets.patch
)

if(VCPKG_LIBRARY_LINKAGE STREQUAL static)
    vcpkg_configure_cmake(
        SOURCE_PATH ${SOURCE_PATH}
        PREFER_NINJA
        OPTIONS
            -DBUILD_SHARED=OFF
            -DBUILD_STATIC=ON
    )
else()
    vcpkg_configure_cmake(
        SOURCE_PATH ${SOURCE_PATH}
        PREFER_NINJA
        OPTIONS
            -DBUILD_SHARED=ON
            -DBUILD_STATIC=OFF
    )
endif()

vcpkg_install_cmake()
vcpkg_copy_pdbs()

file(MAKE_DIRECTORY ${CURRENT_PACKAGES_DIR}/include)	
file(COPY ${SOURCE_PATH}/include/ DESTINATION ${CURRENT_PACKAGES_DIR}/include)
file(INSTALL ${SOURCE_PATH}/LICENSE DESTINATION ${CURRENT_PACKAGES_DIR}/share/liblsl RENAME copyright)
file(INSTALL ${SOURCE_PATH}/README DESTINATION ${CURRENT_PACKAGES_DIR}/share/liblsl)
