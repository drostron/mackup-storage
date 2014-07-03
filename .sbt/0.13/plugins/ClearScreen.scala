import sbt._, Keys._

object ClearScreen extends Plugin {

  override val settings = Seq(commands ++= Seq(
    Command.command("clear-screen") { state ⇒
      print("\033c")
      state
    },
    Command.command("clear-scrollback") { state ⇒
      print("\033]50;ClearScrollback" + 7.toChar) // printf '\e]50;ClearScrollback\a'
      state
    }))

}
