pragma( lib, "liballegro5.lib" );
pragma( lib, "libdallegro5.lib" );
pragma( lib, "jeca.lib" );
pragma( lib, "misc.lib" );

import std.stdio;

import jeca.all;

int main() {
	scope( success ) { writeln( "Exit was successful." ); }
	
   ALLEGRO_DISPLAY *display;
   ALLEGRO_TIMER *timer;

   if (!al_init()) {
      writeln("Could not init Allegro.\n");
      return 1;
   }
   
   al_init_primitives_addon();
   al_install_keyboard();
   al_install_mouse();
   al_init_image_addon();
   al_init_font_addon();

   display = al_create_display(640, 480);
   if (!display) {
      writeln("Could not create display.\n");
      return 1;
   }



	auto FPS = 50;
   timer = al_create_timer(1.000 / FPS);

   auto queue = al_create_event_queue();
   al_register_event_source(queue, al_get_keyboard_event_source());
   al_register_event_source(queue, al_get_mouse_event_source());
   al_register_event_source(queue, al_get_display_event_source(display));
   al_register_event_source(queue, al_get_timer_event_source(timer));

   al_start_timer(timer);
   
   // todo: do run area

   al_destroy_event_queue(queue);

   return 0;
}