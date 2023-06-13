package com.sist.haebollangce.config;

import org.springframework.web.WebApplicationInitializer;
import org.springframework.web.context.ContextLoaderListener;
import org.springframework.web.context.support.AnnotationConfigWebApplicationContext;
import org.springframework.web.filter.CharacterEncodingFilter;
import org.springframework.web.servlet.DispatcherServlet;

import javax.servlet.*;

public class SpringConfig implements WebApplicationInitializer {

    @Override
    public void onStartup(ServletContext servletContext) throws ServletException {

        AnnotationConfigWebApplicationContext rootContext = new AnnotationConfigWebApplicationContext();
        rootContext.register(RootConfig.class);
        // root-context.xml 대체
        servletContext.addListener(new ContextLoaderListener(rootContext));

        // servlet-context 대체
        AnnotationConfigWebApplicationContext sc = new AnnotationConfigWebApplicationContext();
        sc.register(WebConfig.class);

        ServletRegistration.Dynamic dispatcher = servletContext.addServlet("appServlet", new DispatcherServlet(sc));
        dispatcher.setLoadOnStartup(1);
        dispatcher.addMapping("/");

        this.registerCharacterEncodingFilter(servletContext);
    }

    private void registerCharacterEncodingFilter(ServletContext servletContext) {
        FilterRegistration.Dynamic characterEncodingFilter = servletContext.addFilter("encodingFilter", new CharacterEncodingFilter());
        characterEncodingFilter.setInitParameter("encoding", "UTF-8");
        characterEncodingFilter.setInitParameter("forceEncoding", "true");
        characterEncodingFilter.addMappingForUrlPatterns(null, true, "/*");
    }

}

