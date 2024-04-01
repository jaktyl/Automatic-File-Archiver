# Automatic-File-Archiver
This script facilitates backup operations by moving files from a source directory to a target directory. It also manages the number of backups in the target directory, sends email notifications, and allows users to customize backup settings.

### Overview
The script performs the following tasks:
- Checks the existence of the source directory and notifies if it doesn't exist.
- Creates a new target directory if it doesn't exist.
- Moves files from the source directory to the target directory with a timestamped prefix.
- Manages the number of backups in the target directory and deletes older backups if the limit is exceeded.
- Sends email notifications for backup operations.
- Provides options to view backups, change backup settings, and restore backups.

### Script Components
- **Initialization**:
  - Defines source and target directories, current date, time, counter, and email for notifications.

- **Email Notification**:
  - Defines a function `sendEmail` to send email notifications with specified subject and body.

- **Source Directory Check**:
  - Checks if the source directory exists, sends notification if not.

- **Target Directory Creation**:
  - Checks if the target directory exists, creates a new one if not.

- **Backup Process**:
  - Moves files from the source directory to the target directory with a timestamped prefix.
  - Sends email notification for successful backup.

- **Backup Limit Management**:
  - Checks if the number of backups exceeds the maximum allowed.
  - Deletes older backups if the limit is exceeded.
  - Sends email notification for deleted backups.

- **User Interaction**:
  - Provides options for users to change backup settings, view backups, and restore backups.

### Usage
1. Run the script to initiate backup operations.
2. Follow the prompts to view backups, change backup settings, or restore backups as needed.

### Requirements
- Bash shell
- `sendmail` for email notifications
- Ensure proper directory paths and permissions for source and target directories.

### Customization
- Modify source and target directory paths according to your environment.
- Adjust the maximum number of backups allowed as per your requirements.
- Configure email settings for notifications.

There will be an update of the script with a GUI soon
