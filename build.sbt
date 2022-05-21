import org.openurp.parent.Settings._
import org.openurp.parent.Dependencies._

ThisBuild / organization := "org.openurp.std.signup"
ThisBuild / version := "0.0.2-SNAPSHOT"

ThisBuild / scmInfo := Some(
  ScmInfo(
    url("https://github.com/openurp/std-signup"),
    "scm:git@github.com:openurp/std-signup.git"
  )
)

ThisBuild / developers := List(
  Developer(
    id    = "chaostone",
    name  = "Tihua Duan",
    email = "duantihua@gmail.com",
    url   = url("http://github.com/duantihua")
  )
)

ThisBuild / description := "OpenURP Std Minor Signup"
ThisBuild / homepage := Some(url("http://openurp.github.io/std-signup/index.html"))

val apiVer = "0.25.1"
val starterVer = "0.0.20"
val baseVer = "0.1.29"
val openurp_base_api = "org.openurp.base" % "openurp-base-api" % apiVer
val openurp_std_api = "org.openurp.std" % "openurp-std-api" % apiVer
val openurp_stater_web = "org.openurp.starter" % "openurp-starter-web" % starterVer
val openurp_base_tag = "org.openurp.base" % "openurp-base-tag" % baseVer

lazy val root = (project in file("."))
  .settings()
  .aggregate(core,webapp)

lazy val core = (project in file("core"))
  .settings(
    name := "openurp-std-signup-core",
    common,
    libraryDependencies ++= Seq(openurp_base_api,openurp_std_api,beangle_ems_app),
    libraryDependencies ++= Seq(openurp_stater_web,openurp_base_tag,beangle_serializer_text)
  )

lazy val webapp = (project in file("webapp"))
  .enablePlugins(WarPlugin,TomcatPlugin)
  .settings(
    name := "openurp-std-signup-webapp",
    common
  ).dependsOn(core)

publish / skip := true
