import org.grails.datastore.gorm.*
import org.grails.datastore.mapping.query.api.*

result = {
    eq("programCode", "1")
    ne("grade", null)
    "in"("passageIndicator", ["Item", "PassageItem"])
    if (isApproved) {
        eq("status", "APPROVED")
    }
    projections {
        distinct("grade")
    }
}
println result()