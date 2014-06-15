import sbt._
import Keys._
import scala.Console._

object ShellPrompt extends Plugin {
  override def settings = Seq(
    shellPrompt <<= name(name => { state =>
      object devnull extends ProcessLogger {
        def info(s: => String) {}
        def error(s: => String) {}
        def buffer[T](f: => T): T = f
      }
      val current = """\*\s+([\w-./]+)""".r
      def gitBranches = ("git branch --no-color".lines_!(devnull).mkString)
      // println("gitBranches : " + gitBranches)
      // println("current findFirstMatchIn gitBranches : " + current.findFirstMatchIn(gitBranches))
      // access project name : Project.extract(state).currentRef.project
      "%s%s%s:%s%s%s> " format (
        YELLOW,
        name,
        RESET,
        CYAN,
        current findFirstMatchIn gitBranches map (_.group(1)) getOrElse "-",
        RESET)
    })
  )
}