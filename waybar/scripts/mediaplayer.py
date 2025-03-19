#!/usr/bin/env python3
import argparse
import json
import subprocess
import sys
import re

def parse_arguments():
    parser = argparse.ArgumentParser()
    parser.add_argument(
        '-f',
        '--format',
        default='{icon} {}',
        help='Format string'
    )
    parser.add_argument(
        '-p',
        '--playerpath',
        default='playerctl',
        help='Path to playerctl executable'
    )
    parser.add_argument(
        '--player-args',
        default='',
        help='Additional arguments to pass to playerctl'
    )
    return parser.parse_args()

def get_status(playerctl, player_args):
    try:
        return subprocess.check_output([
            playerctl,
            player_args,
            'status'
        ]).decode('utf-8').strip()
    except:
        return "Stopped"

def get_metadata(playerctl, player_args, key):
    try:
        return subprocess.check_output([
            playerctl,
            player_args,
            'metadata',
            key
        ]).decode('utf-8').strip()
    except:
        return ""

def truncate_text(text, max_length=30):
    if len(text) > max_length:
        return text[:max_length-3] + "..."
    return text

def main():
    arguments = parse_arguments()
    status = get_status(arguments.playerpath, arguments.player_args)
    
    if status == 'Stopped':
        print(json.dumps({'text': '', 'class': 'stopped', 'alt': 'Stopped'}))
        sys.exit(0)
    
    if status == 'Paused':
        icon = 'Paused'
    else:
        icon = 'Playing'
    
    try:
        artist = get_metadata(arguments.playerpath, arguments.player_args, 'artist')
        title = get_metadata(arguments.playerpath, arguments.player_args, 'title')
        album = get_metadata(arguments.playerpath, arguments.player_args, 'album')
        
        if artist and title:
            text = f"{artist} - {title}"
        else:
            text = title or artist or "Unknown"
        
        # Truncate for display
        display_text = truncate_text(text)
        
        # Create detailed tooltip
        tooltip = f"{artist}\n{title}"
        if album:
            tooltip += f"\n{album}"
        
        output = arguments.format.format(icon=icon, text=display_text)
        print(json.dumps({
            'text': output,
            'class': status.lower(),
            'alt': status,
            'tooltip': tooltip
        }))
    except Exception as e:
        output = arguments.format.format(icon=icon, text="Unknown")
        print(json.dumps({
            'text': output,
            'class': status.lower(),
            'alt': status,
            'tooltip': f"Error: {e}"
        }))

if __name__ == '__main__':
    main()
