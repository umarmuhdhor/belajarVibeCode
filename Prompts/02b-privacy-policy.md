# Prompt 02a: Generate a Privacy Policy

Use this after you have built your site and give it access to your app codebase to analyze in order to create it.

```text
I need to write a privacy policy for this app that passes the iOS App store guidelines. 

Understand the Apple Appstore privacy recommendations:

https://developer.apple.com/app-store/app-privacy-details/

Can you analyze the code base and write a privacy policy based on apps that have been approved so we can pass testflight?

Example: ~/Documents/appcodebase/

What contact email or support URL should users use for privacy requests?

Example: info@example.com

Who is the legal publisher/operator name for the app? 

Example: name of person with Apple Developer Account

Should the policy say users can request deletion of remotely stored scanned dish/menu text from Supabase, and if so through the same contact?

Example: The data is not stored under the users account that they scanned so could we not allow the users to request deletion and still pass Apple's app review?

Is the app intended for children under 13, or should the policy state it is not directed to children under 13?

Example: No the app is not intended for children under 13

If there is anything ambiguous or not stated please ask me questions to fill in the blanks?

Write it to this markdown file:

content/privacy-policy.md
```