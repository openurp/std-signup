import org.openurp.parent.Settings._
import org.openurp.parent.Dependencies._

ThisBuild / organization := "org.openurp.std.signup"
ThisBuild / version := "0.0.3-SNAPSHOT"

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

val apiVer = "0.44.0"
val starterVer = "0.3.58"
val baseVer = "0.4.51"

val openurp_base_api = "org.openurp.base" % "openurp-base-api" % apiVer
val openurp_std_api = "org.openurp.std" % "openurp-std-api" % apiVer
val openurp_stater_web = "org.openurp.starter" % "openurp-starter-web" % starterVer
val openurp_base_tag = "org.openurp.base" % "openurp-base-tag" % baseVer

lazy val root = (project in file("."))
  .enablePlugins(WarPlugin, TomcatPlugin)
  .settings(
    name := "openurp-std-signup-webapp",
    common,
    libraryDependencies ++= Seq(openurp_base_api,openurp_std_api,beangle_ems_app),
    libraryDependencies ++= Seq(openurp_stater_web,openurp_base_tag,beangle_serializer)
  )
