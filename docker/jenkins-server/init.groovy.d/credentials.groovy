import jenkins.model.*
import hudson.util.Secret
import com.cloudbees.plugins.credentials.*
import com.cloudbees.plugins.credentials.domains.*
import com.cloudbees.plugins.credentials.impl.*
import org.jenkinsci.plugins.plaincredentials.impl.*

// Get Jenkins instance
def instance = Jenkins.getInstance()
def store = instance.getExtensionList('com.cloudbees.plugins.credentials.SystemCredentialsProvider')[0].getStore()

// Fetch environment variables
def awsAccessKeyId = System.getenv('AWS_ACCESS_KEY_ID')
def awsSecretAccessKey = System.getenv('AWS_SECRET_ACCESS_KEY')
def sshPrivateKey = System.getenv('SSH_PRIVATE_KEY')

// Validate the variables before adding credentials
if (awsAccessKeyId && awsSecretAccessKey && sshPrivateKey) {

    // AWS Access Key ID
    def awsAccessKey = new StringCredentialsImpl(
            CredentialsScope.GLOBAL, "aws-access-key", "AWS ACCESS KEY ID", Secret.fromString(awsAccessKeyId))
    store.addCredentials(Domain.global(), awsAccessKey)

    // AWS Secret Access Key
    def awsSecretKey = new StringCredentialsImpl(
            CredentialsScope.GLOBAL, "aws-secret-key", "AWS SECRET ACCESS KEY", Secret.fromString(awsSecretAccessKey))
    store.addCredentials(Domain.global(), awsSecretKey)

    // SSH Private Key
    def sshKey = new BasicSSHUserPrivateKey(
            CredentialsScope.GLOBAL, "ssh-key", "git",
            new BasicSSHUserPrivateKey.DirectEntryPrivateKeySource(sshPrivateKey),
            "", "SSH Private Key")
    store.addCredentials(Domain.global(), sshKey)

    // Save Jenkins configuration
    instance.save()
    println("AWS and SSH credentials added successfully!")
} else {
    println("Error: One or more required environment variables are missing.")
}