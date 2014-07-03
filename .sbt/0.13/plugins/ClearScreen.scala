import sbt._, Keys._

object ClearScreen extends Plugin {

  override def settings = Seq(commands +=
    Command.command("clear-screen") { state ⇒
      println("\033c")
      state
    })

}
