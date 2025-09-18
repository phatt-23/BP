unsigned int OpenGLShader::Compile(
    const std::unordered_map<unsigned int, std::string>& sources
) const {
    EG_PROFILE_FUNCTION();

    EG_CORE_ASSERT(sources.size() >= 0 && sources.size() <= 3,
        "Can only have three shader sources \
        (vertex, geometry, fragment)!");

    unsigned int program;
    EG_OPENGL_CALL(program = glCreateProgram());

    std::vector<unsigned int> shaders(sources.size());
    for (const auto& [type, source] : sources) {
        auto shader = CompileSource(type, source);
        shaders.push_back(shader);
        EG_OPENGL_CALL(glAttachShader(program, shader));
    }

    EG_OPENGL_CALL(glLinkProgram(program));

    int status;
    EG_OPENGL_CALL(glGetProgramiv(program, GL_LINK_STATUS, &status));
    if (status == GL_FALSE) {
        int length;
        EG_OPENGL_CALL(glGetProgramiv(
            program, GL_INFO_LOG_LENGTH, &length));

        std::vector<char> message(length);
        EG_OPENGL_CALL(glGetProgramInfoLog(
            m_RendererID, length, &length, message.data()));

        EG_OPENGL_CALL(glDeleteShader(program));
        for (auto shader : shaders) {
            EG_OPENGL_CALL(glDeleteShader(shader));
        }
        EG_CORE_ERROR("{}", message.data());
        EG_CORE_ASSERT(false, "Shader compilation failed!");
        return 0;
    }

    EG_OPENGL_CALL(glValidateProgram(program));
    for (auto shader : shaders) {
        EG_OPENGL_CALL(glDeleteShader(shader));
    }

    return program;
}

