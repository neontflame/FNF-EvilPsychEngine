package schmovin;

import flixel.FlxG;
import schmovin.SchmovinUtil;
import schmovin.SchmovinAdapter;

// Psych Engine Schmovin' Adapter
class PsychSchmovinAdapter extends SchmovinAdapter
{
	override function forEveryMod(param:Array<Dynamic>)
	{
		trace(param);
	}

	// TODO? - I'm using some random approach but seems to be working!
	// This is used by sustains to render so yeah, Schmovin has been fully implemented now!
	override function getCrotchetAtTime(time:Float):Float
	{
		return Conductor.calculateCrochet(Conductor.getBPMFromSeconds(time).bpm);
	}

	override function grabScrollSpeed():Float
	{
		return PlayState.SONG.speed;
	}

	override function getCrotchetNow():Float
	{
		return Conductor.crochet;
	}

	override function getSongPosition():Float
	{
		return Conductor.songPosition;
	}

	override function getDefaultNoteX(column:Int, player:Int)
	{
		var playerColumn = column % 4;
		var middleScrollShit = (ClientPrefs.middleScroll ? (player == 1 ? 315 : 3000) : 0);

		return (SchmovinUtil.getNoteWidthHalf() + 92 + playerColumn * Note.swagWidth + FlxG.width / 2 * player) - middleScrollShit;
	}

	override function grabGlobalVisualOffset()
	{
		return ClientPrefs.noteOffset;
	}

	override function log(string:Dynamic)
	{
		trace('[Schmovin\' Psych Adapter] $string');
	}

	override function grabReverse()
	{
		return ClientPrefs.downScroll;
	}
}
