ANTI_TEAMKILL_TEAMS_TABLE = ANTI_TEAMKILL_TEAMS_TABLE || { };

hook.Add( "InitPostEntity", "ParseTableAtRightTime", function( )
	 ANTI_TEAMKILL_TEAMS_TABLE = {
	 
	 	[ TEAM_CITIZEN ] = 1;
		[ TEAM_SCAVENGER ] = 2;
		-- Team 1 
		 [ TEAM_USMC1 ] = 3;
		 [ TEAM_USMC2 ] = 3;
		 [ TEAM_USMC3 ] = 3;
		 [ TEAM_USMC4 ] = 3;
		 [ TEAM_USMC5 ] = 3;
		 [ TEAM_USMC6 ] = 3;
		 [ TEAM_USMC7 ] = 3;
		 [ TEAM_USMC8 ] = 3;
		 [ TEAM_USMC9 ] = 3;
		 [ TEAM_USMC10 ] = 3;
		 [ TEAM_USMC11 ] = 3;
		 [ TEAM_USMC12 ] = 3;
		 [ TEAM_USMC13 ] = 3;
		
		-- Team 2
		 [ TEAM_CUBAN1 ] = 4;
		 [ TEAM_CUBAN2 ] = 4;
		 [ TEAM_CUBAN3 ] = 4;
		 [ TEAM_CUBAN4 ] = 4;
		 [ TEAM_CUBAN5 ] = 4;
		 [ TEAM_CUBAN6 ] = 4;
		 [ TEAM_CUBAN7 ] = 4;
		 [ TEAM_CUBAN8 ] = 4;
		 [ TEAM_CUBAN9 ] = 4;
		 [ TEAM_CUBAN10 ] = 4;
		 [ TEAM_CUBAN11 ] = 4;
		 [ TEAM_CUBAN12 ] = 4;
		 [ TEAM_CUBAN13 ] = 4;

		-- Team 3
		 [ TEAM_RUSSIAN1 ] = 5;
		 [ TEAM_RUSSIAN2 ] = 5;
		 [ TEAM_RUSSIAN3 ] = 5;
		 [ TEAM_RUSSIAN4 ] = 5;
		 [ TEAM_RUSSIAN5 ] = 5;
		 [ TEAM_RUSSIAN6 ] = 5;
		 [ TEAM_RUSSIAN7 ] = 5;
		 [ TEAM_RUSSIAN8 ] = 5;
		 [ TEAM_RUSSIAN9 ] = 5;
		 [ TEAM_RUSSIAN10 ] = 5;
		 [ TEAM_RUSSIAN11 ] = 5;
		 [ TEAM_RUSSIAN12 ] = 5;
		 [ TEAM_RUSSIAN13 ] = 5;

		-- Team 4
		 [ TEAM_GERMAN1 ] = 6;
		 [ TEAM_GERMAN2 ] = 6;
		 [ TEAM_GERMAN3 ] = 6;
		 [ TEAM_GERMAN4 ] = 6;
		 [ TEAM_GERMAN5 ] = 6;
		 [ TEAM_GERMAN6 ] = 6;
		 [ TEAM_GERMAN7 ] = 6;
		 [ TEAM_GERMAN8 ] = 6;
		 [ TEAM_GERMAN9 ] = 6;
		 [ TEAM_GERMAN10 ] = 6;
		 [ TEAM_GERMAN11 ] = 6;
		 [ TEAM_GERMAN12 ] = 6;
		 [ TEAM_GERMAN13 ] = 6;

		 -- Team 5
		 [ TEAM_MERC1 ] = 7;
		 [ TEAM_MERC2 ] = 7;
		 [ TEAM_MERC3 ] = 7;
		 [ TEAM_MERC4 ] = 7;
		 [ TEAM_MERC5 ] = 7;
		 [ TEAM_MERC6 ] = 7;
		 [ TEAM_MERC7 ] = 7;
		 [ TEAM_MERC8 ] = 7;
		 [ TEAM_MERC9 ] = 7;


	};
end );

hook.Add("PlayerShouldTakeDamage", "PlayerShouldTakeDamage:AvoidTeamDamage", function( _victim, _attacker )
	if ( IsValid( _victim ) && IsValid( _attacker ) && _victim:IsPlayer( ) && _attacker:IsPlayer( ) ) then
		if (ANTI_TEAMKILL_TEAMS_TABLE[ _victim:Team( ) ] == 1 && ANTI_TEAMKILL_TEAMS_TABLE[ _attacker:Team( ) ] == 1) then
			return true;
		elseif (ANTI_TEAMKILL_TEAMS_TABLE[ _victim:Team( ) ] == 2 && ANTI_TEAMKILL_TEAMS_TABLE[ _attacker:Team( ) ] == 2) then
			return true;
		elseif (ANTI_TEAMKILL_TEAMS_TABLE[ _victim:Team( ) ] == 7 && ANTI_TEAMKILL_TEAMS_TABLE[ _attacker:Team( ) ] == 7) then
			return true;
		else
			if ( ANTI_TEAMKILL_TEAMS_TABLE[ _victim:Team( ) ] == ANTI_TEAMKILL_TEAMS_TABLE[ _attacker:Team( ) ] ) then
			 	return false;
			end
		end	
	end	
end );
