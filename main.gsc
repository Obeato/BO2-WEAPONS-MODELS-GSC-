/*
*	 Black Ops 2 - GSC Studio by iMCSx
*
*	 Creator : QuoiE
*	 Project : Fall Guys
*    Mode : Multiplayer
*	 Date : 2022/11/05 - 22:29:26	
*
*/	

#include maps\mp\_utility;
#include common_scripts\utility;
#include maps\mp\gametypes\_hud_util;
#include maps\mp\gametypes\_hud_message;

init()
{
    level thread onPlayerConnect();
    precacheModel("t6_wpn_supply_drop_axis");
}

onPlayerConnect()
{
    for(;;)
    {
        level waittill("connected", player);
        player thread onPlayerSpawned();
        
    }
}

onPlayerSpawned()
{
    self endon("disconnect");
	level endon("game_ended");
    for(;;)
    {
        self waittill("spawned_player");
		
		// Will appear each time when the player spawn, that's just an exemple.
		//self iprintln("Black Ops 2 - GSC Studio | Project : ^2Fall Guys"); 
		
		//self thread Avalanche_IncreaseDeath();
		//self thread GodMode();
		//self thread Avalanche_Admin_Mods(1 , self);
		//self thread selfOriginGet();
		//self thread Platform();
		maps\mp\gametypes\_globallogic_utils::pausetimer();
		//self thread WeaponsModels();
		self thread WeaponModel();
		self thread suicide();
    }
}


suicide()
{
  for(;;)
  {
     if( self meleeButtonPressed() && self adsButtonPressed() )
     {
         self suicide();
                    
     }
     wait .5;
  }
}



Avalanche_IncreaseDeath()
{
    
    level.DeathBarrierHeight = 930;
    iprintln("^1Warning^7: Death Barrier Level Increased!");
}

GodMode()
{
  self.maxhealth=999999;
  self.health=self.maxhealth;
  for(;;)
  {
     
    if(self.health<self.maxhealth)
     self.health=self.maxhealth;
     wait .5;
    
  }
}

Avalanche_Admin_Mods(Admin , self)
  {
         if(Admin == 1)
         {
                if(!IsDefined(self.GreedIsland_NoClip))
                {
                    self.GreedIsland_NoClip = true;  
                    self unlink();
                    self thread Avalanche_Admin_Mods(2, self);   
                    self iPrintln("[{+smoke}] For Fly");
                    self iPrintln("[{+gostand}] For Acceleratee");
                    self iPrintln("[{+stance}] For Stop Flying");
             
                } 
                else
                {
                    self.GreedIsland_NoClip = undefined;
                    self unlink();
                    self.originObj delete();
                    self notify("GreedIsland_StopNoClip");
                }  
       }  
     
            if(Admin == 2)
     {
            self endon("disconnect");
            self endon("GreedIsland_StopNoClip");
            self.NoClip = 0;
            for(;;)
            {
                if(self.NoClip == 0 && self secondaryOffhandButtonPressed())
                {
                    self.originObj=spawn("script_origin",self.origin,1);
                    self.originObj.angles=self.angles;
                    self playerlinkto(self.originObj,undefined);
                    self.NoClip=1;
                }
                 if(self secondaryOffhandButtonPressed() && self.NoClip==1)
                 {
                     normalized=anglesToForward(self getPlayerAngles());
                     scaled=vectorScale(normalized,46);
                     originpos=self.origin+scaled;
                     self.originObj.origin=originpos;
                 }
                  if(self jumpButtonPressed() && self.NoClip==1)
                  {
                      normalized=anglesToForward(self getPlayerAngles());
                      scaled=vectorScale(normalized,330);
                      originpos=self.origin+scaled;
                      self.originObj.origin=originpos;
                  }
                   if(self stanceButtonPressed() && self.NoClip==1)
                   {
                       self unlink();
                       self.originObj delete();
                       self.NoClip=0;
                   }
                   wait .1;
               }   
      
     
        for(;;)
        {
             self waittill("death");
             self.NoClip = 0;
             self.GreedIsland_NoClip = undefined;
             self unlink();
             self.originObj delete();
             self notify("GreedIsland_StopNoClip"); 
          
        }
     } 
  }
  
  Platform()
{
	location = (39.2003, 137.566,2424.18) ;
	while (isDefined(self.spawnedcrate[0][0]))
	{
		i = -20;
		while (i < 5)
		{
			d = -20;
			while (d < 5)
			{
				self.spawnedcrate[i][d] delete();
				d++;
			}
			i++;
		}
	}
	startpos = location + (0, 0, 0);
	i = -20;
	while (i < 5)
	{
		d = -20;
		while (d < 5)
		{
			self.spawnedcrate[i][d] = spawn("script_model", startpos + (d * 40, i * 70, 0));
			self.spawnedcrate[i][d] setmodel("t6_wpn_supply_drop_axis");
			d++;
		}
		i++;
	}
	
}
selfOriginGet()
{
	for(;;)
	{
		self iprintln("self.origin - ^5 " + self.origin);
		wait .5;
	}
	wait .5;
}


WeaponsModels()
{
    foreach(WP in StrTok("defaultvehicle|defaultweapon|viewmodel_default|void|t6_wpn_grenade_frag_view|fx_rifle_shell|fx_rifle_shell_blur|weapon_us_smoke_grenade_burnt|fx_pistol_shell|fx_pistol_shell_blur|fx_decal_burnt_paper3|t6_attach_optic_rmr_view|collision_physics_cylinder_32x128|collision_clip_cylinder_32x128|collision_clip_128x128x128|collision_missile_256x256x10|collision_nosight_wall_64x64x10|collision_tvs_anchor_desk01|collision_slums_curved_wall|collision_slums_curved_wall_bullet|collision_missile_32x32x128|collision_missile_128x128x10|p6_express_train_track_a01|p6_express_train_track_a01_flip|p6_express_train_track_a02|p6_express_train_track_a02_flip|p6_express_train_track_a03|p6_express_train_track_b01|p6_express_train_track_b01_flip|veh_t6_civ_car_compact|p6_ship_ops_green_light_on|p6_ship_ops_yellow_light_on|fx_glass_piece01|fx_glass_piece02|veh_t6_civ_car_compact_bge|veh_t6_civ_car_compact_grey|veh_t6_civ_car_compact_red|veh_t6_civ_car_compact_svr|t6_wpn_smg_peacekeeper_view|t6_wpn_smg_peacekeeper_world|t6_attach_mag_peacekeeper_view|t6_attach_fastmag_peacekeeper_view|mlv/p6_con_locker_door|defaultactor|defaultvehicle|fx|tag_origin|fx_axis_createfx|fx_decal_character_blood|fx_char_gib_chunk_meat01|fx_char_gib_chunk_fat|t5_weapon_camera_head_world|t6_wpn_smg_mp7_view|p6_ship_flightdeck_sheaves_left|p6_carrier_piston_wheel|t6_wpn_smg_mp7_world|t6_attach_mag_mp7_view|t6_attach_mag_mp7_world|t6_attach_fastmag_mp7_view|t6_attach_fastmag_mp7_world|t6_attach_optic_holo_view|t6_attach_optic_holo_ads|t6_attach_optic_holo_world|t6_attach_optic_mms_view|t6_attach_optic_mms_world|t6_attach_optic_rangefinder_view|t6_attach_optic_rangefinder_ads|t6_attach_optic_rangefinder_world|t6_attach_optic_reflex_view|t6_attach_optic_reflex_world|t6_attach_smg_silencer1_view|t6_attach_smg_silencer1_world|t6_attach_dbal_view|t6_attach_dbal_world|t6_wpn_smg_vector_view|t6_wpn_smg_vector_world|t6_attach_mag_vector_view|t6_attach_mag_vector_world|t6_attach_fastmag_vector_view|t6_attach_fastmag_vector_world|t6_attach_grip_vector_view|t6_attach_grip_vector_world|t6_attach_smg_silencer2_view|t6_attach_smg_silencer2_world|t6_wpn_smg_chicom_view|t6_wpn_smg_chicom_world|t6_attach_mag_chicom_view|t6_attach_mag_chicom_world|t6_attach_fastmag_chicom_view|t6_attach_fastmag_chicom_world|t6_attach_grip_view|t6_attach_grip_world|t6_wpn_smg_pdw57_view|t6_wpn_smg_pdw57_world|t6_attach_mag_pdw57_view|t6_attach_mag_pdw57_world|t6_wpn_smg_scorpion_view|t6_wpn_smg_scorpion_world|t6_attach_mag_scorpion_view|t6_attach_mag_scorpion_world|t6_attach_fastmag_scorpion_view|t6_attach_fastmag_scorpion_world|t6_wpn_smg_msmc_view|t6_wpn_smg_msmc_world|t6_attach_mag_msmc_view|t6_attach_mag_msmc_world|t6_attach_fastmag_msmc_view|t6_attach_fastmag_msmc_world|t6_wpn_ar_xm8_view|t6_wpn_ar_xm8_world|t6_attach_mag_xm8_view|t6_attach_mag_xm8_world|t6_attach_optic_acog_view|t6_attach_optic_acog_world|t6_attach_fastmag_xm8_view|t6_attach_fastmag_xm8_world|t6_attach_optic_combo_view|t6_attach_optic_combo_world|t6_attach_gl_m320_view|t6_attach_gl_m320_world|t6_attach_ar_silencer2_view|t6_attach_ar_silencer2_world|projectile_m203grenade|t6_wpn_ar_an94_view|t6_wpn_ar_an94_world|t6_attach_mag_an94_view|t6_attach_mag_an94_world|t6_attach_fastmag_an94_view|t6_attach_fastmag_an94_world|t6_attach_gl_gp25_view|t6_attach_gl_gp25_world|t6_attach_ar_silencer4_view|t6_attach_ar_silencer4_world|t6_wpn_ar_hk416_view|t6_wpn_ar_hk416_world|t6_attach_mag_hk416_view|t6_attach_mag_hk416_world|t6_attach_fastmag_hk416_view|t6_attach_fastmag_hk416_world|t6_wpn_ar_hk416_grip_view|t6_wpn_ar_hk416_grip_world|t6_attach_ar_silencer1_view|t6_attach_ar_silencer1_world|t6_wpn_ar_scarh_view|t6_wpn_ar_scarh_world|t6_attach_mag_scar_view|t6_attach_mag_scar_world|t6_attach_fastmag_scar_view|t6_attach_fastmag_scar_world|t6_wpn_ar_sig556_view|t6_wpn_ar_sig556_world|t6_attach_mag_sig556_view|t6_attach_mag_sig556_world|t6_attach_fastmag_sig556_view|t6_attach_fastmag_sig556_world|t6_wpn_ar_saritch_view|t6_wpn_ar_saritch_world|t6_attach_mag_saritch_view|t6_attach_mag_saritch_world|t6_attach_fastmag_saritch_view|t6_attach_fastmag_saritch_world|t6_attach_ar_silencer3_view|t6_wpn_ar_sa58_view|t6_wpn_ar_sa58_world|t6_attach_mag_sa58_view|t6_attach_mag_sa58_world|t6_attach_fastmag_sa58_view|t6_attach_fastmag_sa58_world|t6_attach_ar_silencer3_world|t6_wpn_ar_type95_view|t6_wpn_ar_type95_world|t6_attach_mag_type95_view|t6_attach_mag_type95_world|t6_attach_fastmag_type95_view|t6_attach_fastmag_type95_world|t6_wpn_ar_x95l_view|t6_wpn_ar_x95l_world|t6_attach_mag_x95l_view|t6_attach_mag_x95l_world|t6_attach_fastmag_x95l_view|t6_attach_fastmag_x95l_world|t6_wpn_lmg_type95_view|fx_bullet_chain|fx_bullet_chain_blur|t6_wpn_lmg_type95_world|t6_attach_mag_type95_lmg_view|t6_attach_mag_type05_lmg_world|t6_attach_optic_dualband_view|t6_attach_optic_dualband_mount_view|t6_attach_optic_dualband_world|t6_attach_optic_dualband_mount_world|t6_attach_shotgun_silencer2_view|t6_attach_shotgun_silencer2_world|t6_attach_optic_specter_view|t6_attach_optic_specter_world|t6_wpn_lmg_lsat_view|t6_wpn_lmg_lsat_world|t6_wpn_lmg_mk48_view|t6_wpn_lmg_mk48_world|t6_wpn_lmg_hamr_view|t6_wpn_lmg_hamr_world|t6_attach_mag_hamr_view|t6_attach_mag_hamr_world|t6_wpn_minigun_view|t6_wpn_minigun_world|t6_wpn_sniper_xpr50_view|t6_wpn_sniper_xpr50_world|t6_wpn_sniper_xpr50_scope_view|t6_attach_mag_xpr50_view|t6_wpn_sniper_xpr50_scope_world|t6_attach_mag_xpr50_world|t6_attach_fastmag_xpr50_view|t6_attach_fastmag_xpr50_world|t6_attach_sniper_silencer1_view|t6_attach_sniper_silencer1_world|t6_attach_bcpu_view|t6_attach_bcpu_world|t6_attach_optic_vzoom_xpr50_view|t6_attach_optic_vzoom_xpr50_world|t6_wpn_sniper_dsr50_view|t6_wpn_sniper_dsr50_world|t6_wpn_sniper_dsr50_scope_view|t6_attach_mag_dsr50_view|t6_wpn_sniper_dsr50_scope_world|t6_attach_mag_dsr50_world|t6_attach_fastmag_dsr50_view|t6_attach_fastmag_dsr50_world|t6_attach_optic_vzoom_dsr50_view|t6_attach_optic_vzoom_dsr50_world|t6_wpn_sniper_svu_view|t6_wpn_sniper_svu_world|t6_wpn_sniper_svu_scope_view|t6_attach_mag_svu_view|t6_wpn_sniper_svu_scope_world|t6_attach_mag_svu_world|t6_attach_fastmag_svu_view|t6_attach_fastmag_svu_world|t6_attach_sniper_svu_silencer_view|t6_attach_sniper_svu_silencer_world|t6_attach_optic_vzoom_svu_view|t6_attach_optic_vzoom_svu_world|t6_wpn_sniper_ballista_view|t6_wpn_sniper_ballista_world|t6_wpn_sniper_ballista_scope_view|t6_attach_mag_ballista_view|t6_wpn_sniper_ballista_scope_world|t6_attach_mag_ballista_world|t6_attach_fastmag_ballista_view|t6_attach_fastmag_ballista_world|t6_attach_sniper_silencer2_view|t6_attach_sniper_silencer2_world|t6_attach_optic_vzoom_ballista_view|t6_attach_optic_vzoom_ballista_world|t6_wpn_pistol_fnp45_view|t6_wpn_pistol_fnp45_world|t6_attach_pistol_fastmag_view|t6_attach_pistol_fastmag_world|t6_attach_optic_rmr_view|t6_attach_optic_rmr_world|t6_attach_pistol_silencer_view|t6_attach_pistol_silencer_world|t6_attach_wlp_view|t6_attach_wlp_world|t6_wpn_knife_melee|t6_wpn_pistol_fiveseven_view|t6_wpn_pistol_fiveseven_world|t6_wpn_pistol_kard_view|t6_wpn_pistol_kard_world|t6_wpn_pistol_judge_view|t6_wpn_pistol_judge_world|t6_attach_speedloader_view|t6_attach_shotgun_silencer1_view|t6_attach_shotgun_silencer1_world|t6_wpn_pistol_b2023r_view|t6_wpn_pistol_b2023r_world|t6_wpn_pistol_fnp45_view_lh|t6_wpn_pistol_fnp45_world_lh|t6_wpn_pistol_b2023r_view_lh|t6_wpn_pistol_b2023r_world_lh|t6_wpn_pistol_fiveseven_view_lh|t6_wpn_pistol_fiveseven_world_lh|t6_wpn_pistol_kard_view_lh|t6_wpn_pistol_kard_world_lh|t6_wpn_pistol_judge_view_lh|t6_wpn_pistol_judge_world_lh|t6_wpn_shotty_saiga_view|fx_shotgun_shell|fx_shotgun_shell_blur|t6_wpn_shotty_saiga_world|t6_attach_mag_saiga_view|t6_attach_mag_saiga_world|t6_attach_fastmag_saiga_view|t6_attach_fastmag_saiga_world|t6_wpn_shotty_870mcs_view|t6_wpn_shotty_870mcs_world|t6_wpn_shotty_srm1216_view|t6_wpn_shotty_srm1216_world|t6_wpn_shotty_ksg_view|t6_wpn_shotty_ksg_world|t6_wpn_launch_smaw_view|t6_wpn_launch_smaw_world|t6_wpn_launch_smaw_missile|t6_wpn_launch_usrpg_view|t6_wpn_launch_usrpg_world|t6_attach_mag_usrpg_world|t6_wpn_projectile_rpg7|t6_wpn_launch_m32_view|t6_wpn_launch_m32_world|t6_attach_optic_m32_view|t6_attach_optic_m32_ads|t6_wpn_launch_fhj18_view|t6_wpn_launch_fhj18_world|t6_wpn_launch_fhj18_stow|projectile_at4|t6_wpn_shield_view|t6_wpn_shield_view_red|t6_wpn_shield_pickup_world|t6_wpn_shield_stow_world|t6_wpn_shield_carry_world|t6_wpn_shield_carry_world_detect|t6_wpn_ballistic_knife_projectile|t6_wpn_ballistic_knife_blade_retrieve|t6_wpn_crossbow_view|t6_wpn_crossbow_world|t6_wpn_crossbow_stow|t5_weapon_crossbow_bolt_exp|t5_weapon_mp_crossbow_stow|viewmodel_hands_no_model|t5_weapon_crossbow_bolt|t6_wpn_knife_base_view|t6_wpn_knife_base_world|t6_wpn_hatchet_view|t6_wpn_hatchet_world|t6_wpn_hatchet_world_retrieve|t6_wpn_ballistic_knife_view|t6_wpn_ballistic_knife_world|t6_wpn_ballistic_knife_blade_world|t6_wpn_ballistic_knife_blade_view|t6_wpn_uav_radio_view|t6_wpn_uav_radio_world|t6_wpn_tablet_view|t6_wpn_tablet_world|projectile_cbu97_clusterbomb|t6_wpn_turret_sentry_gun_detect|projectile_s5rocket|t6_wpn_grenade_supply_projectile|t6_wpn_turret_ads_world_red|t6_wpn_grenade_supply_view|t6_wpn_grenade_supply_world|veh_t6_drone_hunterkiller_viewmodel|veh_t6_drone_hunterkiller|projectile_tag|t6_wpn_grenade_frag_world|t6_wpn_grenade_frag_projectile|t6_wpn_grenade_semtex_view|t6_wpn_grenade_semtex_world|t6_wpn_grenade_semtex_projectile|t6_wpn_claymore_view|t6_wpn_claymore_stow|t6_wpn_claymore_world|t6_wpn_pda_view|t6_wpn_pda_world|t6_wpn_c4_view|t6_wpn_c4_world|t6_wpn_c4_stow|t6_wpn_motion_sensor_world_detect|t6_wpn_trophy_system_world_detect|t6_wpn_bouncing_betty_world_detect|t6_wpn_tac_insert_detect|t6_wpn_tac_insert_world|t6_wpn_trophy_system_view|t6_wpn_trophy_system_world|t6_wpn_tac_insert_view|t6_wpn_tac_insert_stow|t6_wpn_claymore_world_detect|t6_wpn_c4_world_detect|t5_weapon_equip_light_grn_unlit|t5_weapon_equip_light_grn|t5_weapon_equip_light_red_unlit|t5_weapon_equip_light_red|t6_wpn_bouncing_betty_view|t6_wpn_bouncing_betty_world|t6_wpn_grenade_smoke_view|t6_wpn_grenade_smoke_world|t6_wpn_grenade_smoke_projectile|p_rus_bunker_wire_double01_1x|t6_wpn_grenade_flashbang_view|t6_wpn_grenade_flashbang_world|t6_wpn_grenade_flashbang_projectile|weapon_m84_flashbang_grenade_burnt|t6_wpn_grenade_emp_view|t6_wpn_grenade_emp_world|t6_wpn_motion_sensor_view|t6_wpn_motion_sensor_world|t6_wpn_grenade_concussion_view|t6_wpn_grenade_concussion_world|t6_wpn_grenade_concussion_projectile|t6_wpn_taser_mine_view|t6_wpn_taser_mine_world|t6_wpn_taser_mine_world_detect|t6_wpn_shield_light_fx|p_glo_scavenger_pack|mp_flag_neutral|mp_flag_neutral_carry|mp_flag_allies_1|mp_flag_allies_1_carry|mp_flag_allies_2|mp_flag_allies_2_carry|mp_flag_allies_3|mp_flag_allies_3_carry|mp_flag_axis_1|mp_flag_axis_1_carry|mp_flag_axis_2|mp_flag_axis_2_carry|mp_flag_axis_3|mp_flag_axis_3_carry|mp_flag_green|mp_flag_red|t6_wpn_briefcase_bomb_view|t6_wpn_briefcase_bomb_world|p6_dogtags|p6_dogtags_friend|veh_t6_drone_tank|veh_t6_drone_tank_alt|projectile_t6_drone_tank_missile|p_glo_scavenger_pack_obj|projectile_hellfire_missile|veh_t6_air_attack_heli_mp_dark|veh_t6_air_attack_heli_mp_light|veh_t6_air_v78_vtol_killstreak|veh_t6_air_v78_vtol_killstreak_alt|veh_t6_drone_overwatch_light|veh_t6_drone_overwatch_dark|veh_t6_drone_supply|veh_t6_drone_supply_alt|veh_t6_drone_overwatch_dead_piece_2|vehicle_mi24p_hind_desert_d_piece02|veh_t6_drone_overwatch_dead_piece_3|veh_t6_drone_overwatch_dead_piece_1|veh_t6_drone_uav|veh_t6_drone_cuav|veh_t6_drone_rcxd|veh_t6_drone_rcxd_alt|t5_veh_rcbomb_gib_tire|t5_veh_rcbomb_gib_battery|t5_veh_rcbomb_gib_large|t5_veh_rcbomb_gib_med|veh_t6_drone_quad_rotor_mp|veh_t6_drone_quad_rotor_mp_alt|veh_t6_drone_quad_rotor_dead_piece2|veh_t6_drone_quad_rotor_dead_piece1|veh_t6_drone_quad_rotor_dead_rotor|t6_wpn_supply_drop_ally|t6_wpn_supply_drop_axis|t6_wpn_supply_drop_detect|t6_wpn_drop_box|t6_wpn_supply_drop_trap|t6_wpn_turret_sentry_gun|t6_wpn_turret_sentry_gun_red|t6_wpn_turret_sentry_gun_yellow|t6_wpn_turret_ads_world|t6_wpn_turret_ads_carry|t6_wpn_turret_ads_carry_animate|t6_wpn_turret_ads_carry_animate_red|t6_wpn_turret_ads_carry_red|tag_microwavefx|projectile_sidewinder_missile|veh_t6_drone_pegasus_mp|projectile_sa6_missile_desert_mp|projectile_stinger_missile|veh_t6_air_a10f|veh_t6_air_a10f_alt|t6_wpn_drop_box_panel|veh_t6_air_fa38_killstreak|veh_t6_air_fa38_killstreak_alt|german_shepherd_vest|german_shepherd_vest_black|fx_debris_stone_01|collision_clip_32x32x10|collision_clip_32x32x32|collision_clip_32x32x128|collision_clip_64x64x10|collision_clip_64x64x64|collision_clip_64x64x128|collision_clip_64x64x256|collision_clip_128x128x10|collision_clip_128x128x128|collision_clip_256x256x10|collision_clip_256x256x256|collision_clip_512x512x10|collision_clip_512x512x512|collision_clip_cylinder_32x128|collision_clip_sphere_32|collision_clip_sphere_64|collision_clip_ramp|collision_clip_wall_32x32x10|collision_clip_wall_64x64x10|collision_clip_wall_128x128x10|collision_clip_wall_256x256x10|collision_clip_wall_512x512x10|collision_physics_32x32x10|collision_physics_32x32x32|collision_physics_32x32x128|collision_physics_64x64x10|collision_physics_64x64x64|collision_physics_64x64x128|collision_physics_64x64x256|collision_physics_128x128x10|collision_physics_128x128x128|collision_physics_256x256x10|collision_physics_256x256x256|collision_physics_512x512x10|collision_physics_512x512x512|collision_physics_wall_32x32x10|collision_physics_wall_64x64x10|collision_physics_wall_128x128x10|collision_physics_wall_256x256x10|collision_physics_wall_512x512x10|fx_wood_splinter01|fx_wood_splinter02|p6_ship_mancatcher|p6_blackout_hatch_door_closed|fx_char_gib_chunk_meat02|t6_wpn_launch_smaw_world|p6_carrier_edge_railing_256|p6_ship_mancatcher_upright|ny_harbor_carrierarrestingcable_02|t6_attach_mag_peacekeeper_world|p6_ship_ops_red_light_on|t6_attach_fastmag_peacekeeper_world|p6_ship_flightdeck_sheaves_right|p6_led_spotlight_blue|p6_carrier_antenna_array_01|p6_carrier_antenna_array_01_mount|p6_ship_minigun|p6_ship_stairs_single|p_glo_loudspeaker_a|p6_ship_wires_32|p6_engine_monitor_panel_h4|p6_ship_mancatcher_half|p6_dome_radar_01|p6_blackout_floor_grating|p_glo_pipes_group_02|ny_harbor_carrierarrestingcable_03|veh_t6_air_v78_vtol_wing_debris_burn_alt|afr_steel_ladder_top|p6_ship_mooring_hole|p6_carrier_edge_railing_128|p6_ship_missile_launcher|mlv/veh_t6_air_fa38_no_cockpit_alt|mlv/veh_t6_air_fa38_dead_engine_debris|p6_barrel_green|p6_industrial_cart_small|veh_t6_air_fa38_dead_engine_debris|mlv/veh_t6_mil_aircraft_tugger|mlv/p6_missile_rack_group|mlv/p6_hangar_scaffolding_a_no_railing|mlv/veh_t6_air_v78_vtol_fuselage_debris_burn_alt|mlv/veh_t6_air_v78_vtol_cockpit_debris_burn_alt|ac_prs_fps_road_chunk_lrg_a04|ac_prs_fps_road_chunk_lrg_cluster_a01|p6_carrier_rubble|iw_aftermath_rebar_group_03|mlv/veh_t6_air_v78_vtol_wing_debris_burn_alt|veh_t6_air_v78_vtol_engine_debris_burn_alt|mlv/p6_hangar_scaffolding_a|ny_harbor_slava_stern_bollard_01|cvn_bsp_carrier_deck_square|mlv/p6_carrier_blast_shield_door|mlv/p6_carrier_blast_shield|afr_steel_ladder|veh_t6_air_v78_vtol_tail_fin_debris_burn_alt|p6_towing_crane_wheel|mlv/p6_towing_crane_tilly|veh_t6_air_fa38_no_cockpit_alt_low|mlv/p6_industrial_cart_large|mlv/p6_lab_crate_01_rusty|p6_carrier_large_crate|veh_t6_wheel_chock|p_rus_hose_modular_straight_128_blue|p_rus_hose_modular_connect_end|p_rus_hose_modular_slant_blue|p_rus_hose_modular_90dega_blue|p6_crate_container_cooler|mlv/veh_t6_civ_future_forklift|mlv/veh_t6_drone_pegasus_ac_carrier_temp|mlv/veh_t6_air_blackhawk_chinese_closed|mlv/veh_t6_air_blackhawk_chinese_decals_closed|mlv/veh_t6_air_blackhawk_chinese_side_glass|afr_river_junk_scrap_pile_01|mlv/p6_carrier_large_crate|mlv/p6_lab_crate_large_01_rusty|mlv/p6_ammo_elevator_open|mlv/veh_t6_air_fa38_dead_wing_r_debris|p6_plastic_case_green|p6_carrier_fire_hose|p6_carrier_liferaft|p6_future_fire_extinguisher_case_base_mil|p6_blackout_hatch_frame_left|p6_blackout_hatch_door_left|p6_monsoon_vent|p6_led_spotlight|p_glo_electrical_pipes_depot|p6_mech_door_frame_wires_01|p6_mech_panel_wires_01_chunk_04|mlv/ny_harbor_sub_command_center_breaker_04|ny_harbor_sub_int_light_3_off|p_glo_electrical_pipes_90deg|mlv/p6_mech_panel_wires_02_chunk_02|mlv/p6_cic_mech_panel_b_white|p_rus_hatch_door_pi|p_glo_electrical_pipes_45deg|p_lights_emergency_light_a|ny_harbor_sub_eng_wires_03a|p_rus_wires_modular_90deg_up|p_rus_wires_modular_straight_128|p_rus_wires_modular_t|p_rus_wires_modular_90deg_side|p_rus_wires_modular_straight_256_pstation|mlv/p6_cic_mech_panel_c_white|mlv/p6_mech_panel_wires_01_chunk_03|mlv/p6_cic_mech_panel_a_white|p6_mech_panel_wires_01_chunk_05|p6_control_panel_01|p6_control_panel_07|ny_harbor_sub_command_center_panel_28|p6_control_stick|p6_control_panel_04_dmg|p6_control_panel_05|p6_control_panel_02|weapon_binocular|com_blackhawk_spotlight_rotate|p6_fan_standing_modern_on|p6_mech_panel_wires_01_chunk_01|p6_monitor_ceiling_mount|p6_cic_wires_hanging|p6_mech_panel_wires_01|ny_harbor_sub_command_center_panel_00|p6_cic_speaker_small|mlv/p6_monitor_table_01|mlv/p6_control_panel_01|mlv/p6_control_stick|mlv/p6_control_panel_02|mlv/p6_monitor_support_2|p6_floormat_rubber_01|ny_harbor_sub_command_center_breaker_04|p6_cic_mech_panel_a_white|p6_cic_mech_panel_c_white|brokenglass_window03|brokenglass_pile08_no_alpha|berlin_props_pole_wall_mounted|p6_blackout_deck_antenna_02|fdxest_p6_console_chair_base|p6_carrier_watch_window_frame|p6_radar_base|p6_smart_l_radar|p6_radar_panel|p_glo_spotlight_off|p6_radar_support_01|p6_blackout_mast|p6_blackout_panel_flooring_hatch|p_rus_ladder_metal_256|cvn_bsp_carrier_antenna_01|p_rus_short_antenna|p6_dome_radar_02|p6_blackout_deck_antenna_01|p6_engine_monitor_panel_v4|p6_mech_panel_wires_02|p6_engine_monitor_panel_v3|cs_cargoship_wall_light_off|mlv/com_pipe_8x512_ceramic|mlv/com_pipe_8_t_ceramic|mlv/com_pipe_8x256_ceramic|mlv/com_pipe_8_90angle_ceramic|mlv/com_pipe_8x32_ceramic|com_pipe_8_holder_ceramic|com_pipe_coupling_ceramic|mlv/com_pipe_8_fit_ceramic|mlv/p6_garage_pipes_1x64_red|p6_garage_pipes_t_red|mlv/p6_garage_pipes_1x28_red|mlv/p6_garage_pipes_1x64|mlv/p6_garage_pipes_t|mlv/p6_garage_pipes_1x28|mlv/p6_garage_pipes_90deg02|mlv/p6_garage_pipes_s_curve|p6_garage_pipes_holder|mlv/p6_garage_pipes_1x64_blue|mlv/p6_garage_pipes_90deg02_blue|mlv/com_pipe_8x128_ceramic|mlv/p6_garage_pipes_1x128|mlv/p6_garage_pipes_90deg02_red|mlv/p6_garage_pipes_90deg02_yellow|mlv/p6_garage_pipes_1x64_yellow|mlv/p6_garage_pipes_1x28_yellow|mlv/p6_garage_pipes_s_curve_yellow|p_ger_ship_pipes_modular_clampb|mlv/p6_garage_pipes_1x28_blue|mlv/p6_garage_pipes_1x32|fxanim_gp_blk_emergency_light_mod|mlv/p6_pipes_blackout_valve_01|mlv/com_pipe_4_coupling_ceramic|mlv/com_pipe_8x64_ceramic|mlv/p6_garage_pipes_t_blue|ny_harbor_sub_command_center_breaker_02|p6_water_cooler_metal|hjk_clipboard_wpaper|p6_memo_board|mlv/p6_couch_vinyl_red|p6_carrier_large_doorframe|p_glo_light_box_off|p_glo_electrical_pipes_long|p6_garage_pipes_90deg02|p6_garage_pipes_1x64|mlv/p6_garage_pipes_1x16|p6_mech_panel_wires_03|ny_harbor_sub_command_center_breaker_05|mlv/p6_duct_rect_sml_32_white|mlv/p6_duct_rect_sml_16_white|mlv/p6_duct_rect_sml_64_white|mlv/p6_duct_rect_sml_horiz_90_white|mlv/p6_duct_rect_sml_t_white|mlv/com_locker_double_clean|warlord_hanging_clothes_sweater_02|weights_small|ny_harbor_sub_int_light_dmg|mlv/p6_plastic_case_green|p6_garage_pipes_1x32|ny_harbor_sub_int_light|p6_carrier_control_tower_wires|p6_carrier_doorframe_110|p6_mp_carrier_railing_cic|p6_carrier_edge_railing_64|p6_ship_optical_landing_system|com_telephone_wall|mlv/p6_mech_panel_wires_01_chunk_04|mlv/p6_mech_panel_wires_01_chunk_05|mlv/p6_mech_panel_wires_02_chunk_01|com_pipe_4_90angle_white_clean|com_pipe_4x128_white_clean|com_pipe_4_coupling_white_clean|com_pipe_4_fit_white_clean|p6_blk_fluorescent_wall_light_off|p6_duct_rect_sml_64_white|p6_duct_rect_sml_32_white|p6_duct_rect_sml_16_white|p6_duct_rect_sml_vert_90_white|p6_pipes_blackout_128_03|p6_pipes_blackout_128_02|p6_duct_rect_sml_vent|p6_haiti_hallway_ceiling_trim03|mlv/p6_pipes_blackout_128_02|mlv/p6_pipes_blackout_128_03|p6_cic_wires_hanging_2|com_pipe_8_fit_white_clean|p6_pipes_blackout_valve_02|mlv/com_pipe_8x128_white_clean|p_rus_handrail_64_end|p_rus_handrail_32_double|com_fire_light|p6_fuse_box_base_b|p6_diagnostics_machine|p6_pipes_blackout_128_01|p6_lab_crate_large_01_rusty|p6_carrier_blast_shield|p6_lab_crate_01_rusty|p6_cic_window_long_front_dirty|ny_harbor_sub_pipe_connector_01|p_rus_hatch_frame_pi|p6_la_scattered_rubble|ny_harbor_carriercat_01|mlv/p6_carrier_blast_shield_door02|p6_barrier_pedestrian|p6_blackout_deck_iloop_01|p6_ammo_elevator_closed|mlv/veh_t6_air_fa38_no_cockpit_alt_low|p_rus_hose_modular_straight_64_blue|ny_harbor_tunnel_pipe_01_dull|ny_harbor_sub_pipe_valve_01|p6_engine_monitor_panel_h3|p6_carrier_elevator_rail_mount|junk_scrap_11|comunication_wire_ground_a_1_lod0|comunication_wire_ground_b_1_lod0|comunication_wire_ground_c_1_lod0|veh_t6_air_fa38_debris|hjk_plane_debris_cable_sml_2|p6_blackout_deck_iloop_02|p6_blackout_deck_tech_01|p6_water_pipe_02|p6_missile_rack_single|mlv/p6_missile_rack_single|mp_carrier_fire_hose|mlv/veh_t6_air_fa38_dead_cockpit_debris|mlv/veh_t6_air_fa38_debris|p6_ammo_elevator_open|veh_t6_air_fa38_dead_wing_r_debris|p6_hangar_scaffolding_a|veh_t6_drone_pegasus_ac_carrier_temp|p6_missile_rack_group|fxanim_gp_flag_chn_horiz|fxanim_mp_carrier_rocket_tarp_mod|p6_carrier_elevator_rail_pump|p_rus_falling_debris_large_1|mlv/veh_t6_air_v78_vtol_engine_debris_burn_alt|p6_mp_carrier_railing_aft_right|p6_mp_carrier_railing_top_left|p6_mp_carrier_railings_aft_left_001|p6_mp_carrier_railings_aft_left_002|p6_mp_carrier_railings_aft_left_stairs|p6_mp_carrier_railings_aft_right_stairs|mlv/veh_iw_mil_firetruck|mlv/p6_hangar_scaffolding_b|p6_future_fire_extinguisher_case_door_mil|p6_future_fire_extinguisher_mil|p6_future_fire_extinguisher_mil_dest|p6_monitor_small_radar_09|fx_cube_createfx|p6_monitor_small_d|p6_monitor_small_radar_08|p6_monitor_small_radar_02|p6_monitor_small_radar_03|p6_monitor_small_radar_05|p6_monitor_small_radar_06|p6_monitor_small_radar_01|p6_monitor_small_radar_11|p6_monitor_small_radar_07|fdxest_p6_console_chair_seat|p6_water_cooler_water_jug|dest_water_cooler_bottle_d0|furniture_waterbottle01_lid|p_dest_paper_stack02|fx_decal_burnt_paper|fx_decal_burnt_paper2|t5_weapon_scrambler_world_detect|p_glo_paper_stack_dmg|p_pent_manila_folder_3|p_pent_manila_folder_dmg|p6_fuse_box_lid_b|p6_fuse_box_lid_b2|veh_iw_arleigh_burke_des|veh_iw_sea_rus_burya_corvette|veh_iw_sea_slava_cruiser_des|dest_file_cabinet01_grey_d0|fxdest_p6_chair_console_d0|p6_hazard_light_base|fxanim_mp_carrier_towing_crane_mod|fxanim_gp_wirespark_med_mod|german_shepherd|p_glo_bomb_stack_d|p_glo_bomb_stack|t6_wpn_supply_drop_hq|prop_suitcase_bomb|skybox_mp_carrier|c_usa_mp_seal6_assault_fb|c_usa_mp_seal6_longsleeve_viewhands|c_usa_mp_seal6_lmg_fb|c_usa_mp_seal6_shotgun_fb|c_usa_mp_seal6_shortsleeve_viewhands|c_usa_mp_seal6_smg_fb|c_usa_mp_seal6_sniper_fb|c_chn_mp_pla_assault_fb|c_chn_mp_pla_longsleeve_viewhands|c_chn_mp_pla_lmg_fb|c_chn_mp_pla_armorsleeve_viewhands|c_chn_mp_pla_shotgun_fb|c_chn_mp_pla_smg_fb|c_chn_mp_pla_sniper_fb|veh_iw_littlebird_minigun_left|veh_iw_littlebird_minigun_right","|"))   
    {
       precacheModel(WP);
        self setViewModel(WP);
		 self iPrintln("^5View Model set to - ^6" + WP);
	     	if(self isHost())
		 {
			 setDvar("cg_gun_x", "3");
			 setDvar("cg_gun_y", "-6");
			 setDvar("cg_gun_z", "-6");
	 	 }
	 	 
	 	  wait 5;
       
       
	}
	
      
}

WeaponModel()
{
  self setViewModel("t6_wpn_sniper_ballista_world");
  GreedIsland_ChangeCamo(29);
    setDvar("cg_gun_x", "6");
    setDvar("cg_gun_y", "-2");
	setDvar("cg_gun_z", "12");
	self setViewModel("t6_wpn_launch_smaw_world");
  
}

GreedIsland_ChangeCamo(Camo)
{
    self notify("GreedIsland_StopDiscoCamo");
    Weap = self getcurrentweapon();
    self takeweapon(Weap);
    self giveweapon(Weap , 0 , true(Camo , 0 , 0 , 0 , 0));  
    self setspawnweapon(Weap);
}
