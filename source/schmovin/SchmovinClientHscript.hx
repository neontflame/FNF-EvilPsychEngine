/**
 * @ Author: 4mbr0s3 2
 * @ Create Time: 2021-07-25 01:14:35
 * @ Modified by: 4mbr0s3 2
 * @ Modified time: 2021-08-29 15:09:32
 */

package schmovin;

#if sys
import sys.FileSystem;
import sys.io.File;
#end

class SchmovinClientHscript extends SchmovinClient
{
	override function initialize()
	{
		var songName:String = Paths.formatToSongPath(PlayState.SONG.song);

		#if sys
		if (FileSystem.exists(Paths.hx("data/" + songName.toLowerCase() + '/modchart')))
		{
			var swaggy:String = File.getContent(Paths.hx("data/" + songName.toLowerCase() + '/modchart'));

			parseHScript(swaggy);
		}
		#end
		// when beat, percent, modifier, player
		// set(1, 2, 'beat');
	}
}
