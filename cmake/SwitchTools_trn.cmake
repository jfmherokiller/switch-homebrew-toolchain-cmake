set(Python_ADDITIONAL_VERSIONS 3.4 3.5 3.6)
find_package(PythonInterp 3 REQUIRED)

set(CONVERTER "${LIBTRN}/tools/elf2nxo.py")

function(add_nro_target target)
    get_filename_component(target_we ${target} NAME_WE)
    if ((NOT (${ARGC} GREATER 1 AND "${ARGV1}" STREQUAL "NO_HDR")) OR (${ARGC} GREATER 3))
        if (${ARGC} GREATER 3)
            set(APP_TITLE ${ARGV1})
            set(APP_AUTHOR ${ARGV2})
            set(APP_VERSION ${ARGV3})
        endif ()
        if (${ARGC} EQUAL 5)
            set(APP_ICON ${ARGV4})
        endif ()
        if (NOT APP_TITLE)
            set(APP_TITLE ${target})
        endif ()
        if (NOT APP_AUTHOR)
            set(APP_AUTHOR "Unspecified Author")
        endif ()
        if (NOT APP_VERSION)
            set(APP_VERSION "1.0")
        endif ()
        if (NOT APP_ICON)
            if (EXISTS ${target}.png)
                set(APP_ICON ${target}.png)
            elseif (EXISTS icon.png)
                set(APP_ICON icon.png)
            else ()
                message(FATAL_ERROR "No icon found ! Please use NO_SMDH or provide some icon.")
            endif ()
        endif ()
        if (CMAKE_RUNTIME_OUTPUT_DIRECTORY)
            add_custom_command(OUTPUT ${CMAKE_RUNTIME_OUTPUT_DIRECTORY}/${target_we}.nro
                    COMMAND ${PYTHON_EXECUTABLE} ${CONVERTER} -n ${APP_TITLE} -d ${APP_AUTHOR} -v ${APP_VERSION} -i ${APP_ICON} $<TARGET_FILE:${target}> ${CMAKE_RUNTIME_OUTPUT_DIRECTORY}/${target_we}.nro nro
                    DEPENDS ${target} ${CMAKE_CURRENT_BINARY_DIR}/${target_we}.nacp
                    VERBATIM
                    )
        else ()
            add_custom_command(OUTPUT ${CMAKE_CURRENT_BINARY_DIR}/${target_we}.nro
                    COMMAND ${PYTHON_EXECUTABLE} ${CONVERTER} -n ${APP_TITLE} -d ${APP_AUTHOR} -v ${APP_VERSION} -i ${APP_ICON} $<TARGET_FILE:${target}> ${CMAKE_CURRENT_BINARY_DIR}/${target_we}.nro nro
                    DEPENDS ${target} ${CMAKE_CURRENT_BINARY_DIR}/${target_we}.nacp
                    VERBATIM
                    )
        endif ()
    else ()
        message(STATUS "No header will be generated")
        if (CMAKE_RUNTIME_OUTPUT_DIRECTORY)
            add_custom_command(OUTPUT ${CMAKE_RUNTIME_OUTPUT_DIRECTORY}/${target_we}.nro
                    COMMAND ${PYTHON_EXECUTABLE} ${CONVERTER} $<TARGET_FILE:${target}> ${CMAKE_RUNTIME_OUTPUT_DIRECTORY}/${target_we}.nro nro
                    DEPENDS ${target}
                    VERBATIM
                    )
        else ()
            add_custom_command(OUTPUT ${CMAKE_CURRENT_BINARY_DIR}/${target_we}.nro
                    COMMAND ${PYTHON_EXECUTABLE} ${CONVERTER} $<TARGET_FILE:${target}> ${CMAKE_CURRENT_BINARY_DIR}/${target_we}.nro nro
                    DEPENDS ${target}
                    VERBATIM
                    )
        endif ()

    endif ()
    if (CMAKE_RUNTIME_OUTPUT_DIRECTORY)
        add_custom_target(${target_we}_nro ALL SOURCES ${CMAKE_RUNTIME_OUTPUT_DIRECTORY}/${target_we}.nro)

    else ()
        add_custom_target(${target_we}_nro ALL SOURCES ${CMAKE_CURRENT_BINARY_DIR}/${target_we}.nro)
    endif ()
endfunction()
