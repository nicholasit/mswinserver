
# Get all installed license packs
$licensepacks = gwmi win32_tslicensekeypack | where {($_.keypacktype -ne 0) -and ($_.keypacktype -ne 4) -and ($_.keypacktype -ne 6)};
 
# Get total number of licenses across all license packs
$totallicenses = ($licensepacks | measure-object -sum totallicenses).sum;
 
# Define 80 percent threshold
$eightypercent = [Math]::Floor([decimal]($totallicenses*0.8));
 
# Get all licenses currently assigned to devices
$licensesinuse = gwmi win32_tsissuedlicense | where {$_.licensestatus -eq 2};
 
# Number of licenses in use
$licensesinusecount = ($licensesinuse | measure-object).count;
 
# How many licenses above 80 percent are in use
$licensecounttorevoke = $licensesinusecount - $eightypercent;
 
# If more than 80 percent of licenses are in use
if ($licensecounttorevoke > 0) {
 
    # Select and revoke only the number of licenses above 80%, oldest first
    $licensestorevoke = $licensesinuse | sort expirationdate | select -first $licensecounttorevoke;
    $licensestorevoke.revoke();
 
}
 
#Revoke all license

    $licensesinuse = gwmi win32_tsissuedlicense | where {$_.licensestatus -eq 2};

    $licensesinuse.revoke();