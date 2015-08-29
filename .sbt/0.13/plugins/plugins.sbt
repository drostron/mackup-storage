resolvers += "sonatype snapshots" at "http://oss.sonatype.org/content/repositories/snapshots/"

addSbtPlugin("com.github.mpeltonen" % "sbt-idea" % "1.6.0")

addSbtPlugin("com.timushev.sbt" % "sbt-updates" % "0.1.7")

addSbtPlugin("net.virtual-void" % "sbt-dependency-graph" % "0.7.5")

// causing issue with scalariform configs; overriding? o_O
// addSbtPlugin("org.ensime" % "ensime-sbt" % "0.1.7")
