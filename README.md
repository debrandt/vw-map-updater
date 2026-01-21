# VW Map Updater

Automated tool for updating Volkswagen/TomTom navigation SD cards with size optimization.

## Problem

Older Volkswagen vehicles came with 16GB SD cards for navigation data. Over time, official TomTom map updates have grown larger than this capacity, making it impossible to install current updates without buying a new SD card or manually removing unwanted regions.

This tool automates the process of:
- Extracting map update archives
- Removing unwanted geographic regions to fit your SD card
- Copying optimized maps to your card

## Features

- 🚀 Automated extraction and region deletion
- 📊 Shows region sizes before and after cleanup
- 🔍 Auto-detects SD card by label
- ✅ Interactive confirmations for safety
- 🎨 Color-coded terminal output
- 🔧 NixOS-native with dependency management via nix-shell

## Requirements

- NixOS (or any system with Nix package manager)
- VW/TomTom map update archive (.7z file)
- SD card (8GB+ recommended after cleanup)

## Installation

```bash
git clone https://github.com/YOUR_USERNAME/vw-map-updater.git
cd vw-map-updater
chmod +x vw-map-update
```

## Configuration

Edit the script header to customize:

```bash
REGIONS_TO_DELETE=("E3" "E8" "E10")  # Regions to remove
SD_CARD_LABEL="SD_CARD"               # Your SD card label
```

### Region Reference

Based on typical TomTom NDS region codes:

- **E1** - Northern Europe (Sweden, Norway, Finland, Denmark)
- **E2** - Eastern Europe (Poland, Czech Republic, Hungary, Slovakia, etc.)
- **E3** - UK & Ireland
- **E4** - Southern Europe (Italy, Spain, Portugal, Greece)
- **E5** - France
- **E6** - Benelux (Belgium, Netherlands, Luxembourg)
- **E8** - Baltic States (Estonia, Latvia, Lithuania)
- **E10** - Balkans (Serbia, Bosnia, Albania, etc.)
- **E11** - Central Europe (Germany, Austria, Switzerland)
- **E12** - Additional regions (varies)
- **E13** - Additional regions (varies)

> **Note:** Region codes may vary between map versions. Always check sizes before deleting.

## Usage

1. Download your VW map update (.7z file) to `~/Downloads`

2. Run the script:
   ```bash
   ./vw-map-update
   ```
   
   Or using nix-shell explicitly:
   ```bash
   nix-shell --run ./vw-map-update
   ```

3. The script will:
   - Find the latest .7z archive
   - Extract it
   - Show region sizes
   - Ask for confirmation before deleting regions
   - Detect and mount your SD card
   - Copy optimized maps to the SD card

## Example Output

```
[INFO] Starting VW Map Update Process
[INFO] Found archive: DiscoverMedia2_EU3_2210_V19.7z
[INFO] Extracting DiscoverMedia2_EU3_2210_V19.7z...
[INFO] Current regions and sizes:
2.6G    ./E2
2.2G    ./E11
1.8G    ./E1
1.7G    ./E4
1.6G    ./E5
1.6G    ./E3
...
Delete regions E3 E8 E10? (y/N):
```

## Development

Enter the development environment:

```bash
nix-shell
```

This loads all dependencies (p7zip, util-linux, coreutils) automatically.

## How It Works

The script uses the NDS (Navigation Data Standard) format used by TomTom. Map data is organized into regional directories (E1, E2, etc.), each containing:

- `ROUTING.NDS` - Road network data
- `POI.NDS` - Points of interest
- `NAME.NDS` - Place names
- `BMD.NDS` - Building models
- Other regional data files

By removing entire region directories you don't need, you can significantly reduce the total map size.

## Compatibility

Tested with:
- VW Discover Media 2
- TomTom NDS format map updates
- NixOS (should work on any Linux with Nix)

May work with other VW/Audi/Skoda/SEAT navigation systems using TomTom maps.

## Safety Notes

- ⚠️ **Always backup your original SD card** before updating
- The script asks for confirmation before destructive operations
- Keep your original .7z archive in case you need to start over
- Test the updated SD card in your car before deleting the backup

## Troubleshooting

**"No .7z archive found"**
- Ensure your map update .7z file is in `~/Downloads`

**"SD card not found"**
- The script will prompt you to enter the device path manually
- Use `lsblk` to identify your SD card device

**Navigation system doesn't recognize the card**
- You may have deleted a required region
- Restore from your backup and try removing fewer regions

**Still too large after deletion**
- Check region sizes with `du -sh maps/00/nds/PRODUCT/E*`
- Consider removing additional regions
- Some critical regions (like E11 for Germany) may be unavoidable

## Contributing

Contributions welcome! Please:
- Test changes with your VW navigation system
- Update region code documentation if you discover new mappings
- Share which regions work for your use case

## License

MIT License - see [LICENSE](LICENSE) file

## Disclaimer

This tool is not affiliated with Volkswagen or TomTom. Use at your own risk. Always maintain backups of your original navigation data.

---

**Found this useful?** Star the repo and share your region configuration in the Issues/Discussions!
