<?php

/*
 * This class represents a track that the user 
 * uploads to their profile. It serves as the link
 * between database and track information.
 */
class Track {

	const DB_TABLE = 'track';

	protected $track_name;
	protected $track_path;
	protected $track_album;
	protected $track_owner;

	public function __construct($args = array()) {
		$defaultArgs = array(
            'track_name' => '',
            'track_path' => '',
            'track_album' => null,
            'track_owner' => null,
            );

		$args += $defaultArgs;
       	
        $this->track_name = $args['track_name'];
        $this->track_path = $args['track_path'];
        $this->track_album = $args['track_album'];
        $this->track_owner = $args['track_owner'];
	}

	//Saves/modifies track information 
	public function save($newTrackName = null, $newTrackPath = null) {
		$db = Db::instance();

		if (self::doesTrackExist($this->track_name, $this->track_album, $this->track_owner) != null) {
			if ($newTrackName) {
				$query = sprintf("update %s set `%s` = '%s', `%s` = '%s' where `%s` = '%s' and `%s` = '%s' and `%s` = '%s'",
				self::DB_TABLE,
				'track_name',
				mysql_real_escape_string($newTrackName),
				'track_path',
				mysql_real_escape_string($newTrackPath),
				'track_album',
				mysql_real_escape_string($this->track_album),
				'track_owner',
				mysql_real_escape_string($this->track_owner),
				'track_name',
				mysql_real_escape_string($this->track_name)
				);
				$db->execute($query);
			}
		} else {
			$query = sprintf("insert into %s (`%s`, `%s`, `%s`, `%s`) values ('%s', '%s', '%s', '%s')",
				self::DB_TABLE,
				'track_name',
				'track_album',
				'track_owner',
				'track_path',
				mysql_real_escape_string($this->track_name),
				mysql_real_escape_string($this->track_album),
				mysql_real_escape_string($this->track_owner),
				mysql_real_escape_string($this->track_path)
				);
				$db->execute($query);
		}
	}

	//Local method to check existence.. used so I can reference protected variables
	public function doesTrackExist($track_name, $track_album, $track_owner) {
		return self::trackExist($track_name, $track_album, $track_owner);
	}

	//Checks to see if the track exists
	public static function trackExist($track_name, $track_album, $track_owner)
	{
		$db = Db::instance();

		$query = sprintf("SELECT * from %s WHERE `track_name` = '%s' and `track_album` = '%s' and `track_owner` = '%s'",
			self::DB_TABLE,
			mysql_real_escape_string($track_name),
			mysql_real_escape_string($track_album),
			mysql_real_escape_string($track_owner)
			);

		$result = $db->lookup($query);
		if(!mysql_num_rows($result)) {
			return null;
		} else {
			$row = mysql_fetch_assoc($result);
			$track = new Track($row);
			return $track;
		}	
	}

	//Returns all public information about the track
	public static function publicTrackInfo($track_name, $track_album, $track_owner) {
		$track = self::trackExist($track_name, $track_album, $track_owner);

		if ($track) {
			$information = array(
				"track_name" => $track->track_name,
				"track_album" => $track->track_album,
				"track_owner" => $track->track_owner,
				"track_path" => $track->track_path
				);
			return $information;
		} else {
			return null;
		}
	}

	//Deletes the track from the album
	public static function deleteTrack($track_name, $track_album, $track_owner) {
		if (self::doesTrackExist($track_name, $track_album, $track_owner) != null) {
			$query = sprintf("Delete from %s where `track_name` = '%s' and `track_album` = '%s' and `track_owner` = '%s'",
				self::DB_TABLE,
				mysql_real_escape_string($track_name),
				mysql_real_escape_string($track_album),
				mysql_real_escape_string($track_owner)
				);
			$db = Db::instance();
			$db->execute($query);
			return true;
		} else {
			return null;
		}
	}
    
    // get an array of tracks for the album that belongs to a specified owner
    public static function getTracks($track_album, $track_owner) {
    	$db = Db::instance();

        $query = sprintf(" SELECT * FROM `%s`
                WHERE `%s` = '%s'
                and `%s` = '%s'
                ORDER BY `track_name` ASC ",
                self::DB_TABLE,
                "track_album",
                mysql_real_escape_string($track_album),
                "track_owner",
                mysql_real_escape_string($track_owner)
            );
        
        $result = $db->lookup($query);
        if(!mysql_num_rows($result))
            return null;
        else {
            $tracks = array();
            while($row = mysql_fetch_assoc($result)) {
                $tracks[] = self::publicTrackInfo($row['track_name'], $row['track_album'], $row['track_owner']);
            }
            return ($tracks);
        }
    }
}