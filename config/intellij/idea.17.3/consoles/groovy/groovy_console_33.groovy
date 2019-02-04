import org.springframework.security.core.context.SecurityContextHolder

println groovy.json.JsonOutput.toJson(SecurityContextHolder.getContext().setAuthentication(authentication))
