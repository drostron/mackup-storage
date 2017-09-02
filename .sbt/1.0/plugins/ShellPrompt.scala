import sbt._, Keys._
import scala.Console._
import scala.sys.process._

object ShellPrompt extends AutoPlugin {
  override def trigger = allRequirements

  override lazy val buildSettings = Seq(
    shellPrompt := { state =>
      val current = """\*\s+([\w-./]+)""".r
      def gitBranches = ("git branch --no-color" !!)
      "%s%s%s:%s%s%s> " format (
        YELLOW,
        Project.extract(state) get Keys.name,
        RESET,
        CYAN,
        current findFirstMatchIn gitBranches map (_.group(1)) getOrElse "-",
        RESET)
    }
  )
}
