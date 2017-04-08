import sbt._, Keys._
import scala.Console._

object ShellPrompt extends Plugin {
  override def settings = Seq(
    shellPrompt := { state =>
      object devnull extends ProcessLogger {
        def info(s: => String) {}
        def error(s: => String) {}
        def buffer[T](f: => T): T = f
      }
      val current = """\*\s+([\w-./]+)""".r
      def gitBranches = ("git branch --no-color".lines_!(devnull).mkString)
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
