import jenkins.model.*
import hudson.security.*
import java.util.logging.Logger

def instance = Jenkins.getInstance()
def logger = Logger.getLogger("")

def env = System.getenv()
def user = env['JENKINS_USER'] ?: "rahulnetha"
def pass = env['JENKINS_PASS'] ?: "rahulnetha"
def fullName = env['JENKINS_FULLNAME'] ?: "Rahul Swargam"
def email = env['JENKINS_EMAIL'] ?: "swargamrahul@gmail.com"

// Set security realm
def hudsonRealm = new HudsonPrivateSecurityRealm(false)
hudsonRealm.createAccount(user, pass)
instance.setSecurityRealm(hudsonRealm)

// Assign permissions
def strategy = new FullControlOnceLoggedInAuthorizationStrategy()
strategy.setAllowAnonymousRead(false)
instance.setAuthorizationStrategy(strategy)

// Save settings
instance.save()
logger.info("Jenkins Admin User Created: ${user}")