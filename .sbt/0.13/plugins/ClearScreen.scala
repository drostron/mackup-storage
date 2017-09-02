import sbt._, Keys._

object ClearScreen extends AutoPlugin {
  override def trigger = allRequirements

  override lazy val buildSettings = Seq(commands ++= Seq(
    Command.command("clear-screen") { state ⇒
      print("\u001bc")
      state
    },
    Command.command("clear-scrollback") { state ⇒
      print("\u001b]50;ClearScrollback" + 7.toChar) // printf '\e]50;ClearScrollback\a'
      state
    }))

}
