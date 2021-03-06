/**
 * Uses the DMD compiler, but allows you to use wildcards
 * ---
 * dmj -c -D *.d
 * ---
 * Bug: Can't do more than one folder at a time.
 */
module dmj;

import wildcard.wildcard;

import std.stdio;
import std.string;
import std.file;
import std.process;
import std.path;

void main( string[] args ) {
	string line;
	line ~= "dmd";
	foreach( arg; args[ 1 .. $] ) {
		bool notSourceFile = true;
		// use wildcard if: found ".d", or both the first char is a '-' and no dot
		if ( arg.indexOf( ".d" ) != -1 || ( arg[0] != '-' && arg.indexOf( "." ) == -1 ) ) {
			// *.d
			// model\*.d
			string path;
			if ( arg == "*.d" )
				path = ".";
			else
				path = `.\` ~ arg[ 0 .. arg.indexOf( "." ) - 1 ];
			debug writeln( path, " with fries" );
			foreach ( string name; dirEntries( path, SpanMode.shallow ) ) {
				debug writeln( "house of ", name );
				if ( wildMatch( arg, name[ 2 .. $ ] ) ) {
					line ~= ' ' ~ name[ 2 .. ( arg.indexOf( "." ) ==  -1 ? $ : $ - 2 ) ];
					notSourceFile = false;
				}
			}
		}
		if ( notSourceFile )
			line ~= ' ' ~ arg;
	}
	writeln( line );
	system( line );
}
