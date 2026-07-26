import com.android.build.gradle.AppExtension

val android = project.extensions.getByType(AppExtension::class.java)

android.apply {
    flavorDimensions("flavor")

    productFlavors {
        create("dev") {
            dimension = "flavor"
            applicationId = "tech.tetrabox.flutter_app_template.dev"
            resValue(type = "string", name = "app_name", value = "Template Dev")
        }
        create("prod") {
            dimension = "flavor"
            applicationId = "tech.tetrabox.flutter_app_template"
            resValue(type = "string", name = "app_name", value = "Template")
        }
    }

    buildFeatures.resValues = true
}