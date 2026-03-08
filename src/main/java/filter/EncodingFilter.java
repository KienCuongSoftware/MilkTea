package filter;

import java.io.IOException;

import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;

/**
 * Sets request and response encoding to UTF-8.
 * Use in web.xml instead of Spring's CharacterEncodingFilter to avoid ClassNotFoundException
 * when filter is loaded before Spring libraries.
 */
public class EncodingFilter implements Filter {

    private String encoding = "UTF-8";
    private boolean forceEncoding = true;

    @Override
    public void init(FilterConfig filterConfig) throws ServletException {
        String enc = filterConfig.getInitParameter("encoding");
        if (enc != null) {
            encoding = enc;
        }
        String force = filterConfig.getInitParameter("forceEncoding");
        if (force != null) {
            forceEncoding = Boolean.parseBoolean(force);
        }
    }

    @Override
    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
            throws IOException, ServletException {
        if (encoding != null) {
            if (forceEncoding || request.getCharacterEncoding() == null) {
                request.setCharacterEncoding(encoding);
            }
            if (forceEncoding || response.getCharacterEncoding() == null) {
                response.setCharacterEncoding(encoding);
            }
        }
        chain.doFilter(request, response);
    }
}
