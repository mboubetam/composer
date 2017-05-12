(cat > composer.sh; chmod +x composer.sh; exec bash composer.sh)
#!/bin/bash
set -ev

# Get the current directory.
DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# Get the full path to this script.
SOURCE="${DIR}/composer.sh"

# Create a work directory for extracting files into.
WORKDIR="$(pwd)/composer-data"
rm -rf "${WORKDIR}" && mkdir -p "${WORKDIR}"
cd "${WORKDIR}"

# Find the PAYLOAD: marker in this script.
PAYLOAD_LINE=$(grep -a -n '^PAYLOAD:$' "${SOURCE}" | cut -d ':' -f 1)
echo PAYLOAD_LINE=${PAYLOAD_LINE}

# Find and extract the payload in this script.
PAYLOAD_START=$((PAYLOAD_LINE + 1))
echo PAYLOAD_START=${PAYLOAD_START}
tail -n +${PAYLOAD_START} "${SOURCE}" | tar -xzf -

# Pull the latest Docker images from Docker Hub.
docker-compose pull
docker pull hyperledger/fabric-baseimage:x86_64-0.1.0
docker tag hyperledger/fabric-baseimage:x86_64-0.1.0 hyperledger/fabric-baseimage:latest

# Kill and remove any running Docker containers.
docker-compose -p composer kill
docker-compose -p composer down --remove-orphans

# Kill any other Docker containers.
docker ps -aq | xargs docker rm -f

# Start all Docker containers.
docker-compose -p composer up -d

# Wait for the Docker containers to start and initialize.
sleep 10

# Open the playground in a web browser.
case "$(uname)" in 
"Darwin")   open http://localhost:8080
            ;;
"Linux")    if [ -n "$BROWSER" ] ; then
	       	        $BROWSER http://localhost:8080
	        elif    which xdg-open > /dev/null ; then
	                 xdg-open http://localhost:8080
	        elif  	which gnome-open > /dev/null ; then
	                gnome-open http://localhost:8080
                       #elif other types bla bla
	        else   
		            echo "Could not detect web browser to use - please launch Composer Playground URL using your chosen browser ie: <browser executable name> http://localhost:8080 or set your BROWSER variable to the browser launcher in your PATH"
	        fi
            ;;
*)          echo "Playground not launched - this OS is currently not supported "
            ;;
esac

# Exit; this is required as the payload immediately follows.
exit 0
PAYLOAD:
� �Y �[o�0�yxᥐ�����$
.E%��OQH\��MΥeS���ABºJզI�I�r����9��	�"M;�� B���������]���w�,�bM�%�-v$�S��$�5 �(e�(� ��X)�N�^�����D8�P���E���F�r���%���fo `�Z!��!".rV�֒`��S>]w�N�)�:-��b���G/��+Zl�]��)&��!?>��p|5][��~�����nT8��$A����g�������P|-�!�hE��(�$f���f�(�df����T��B�����ܘ���a�{�bL1�MG����I!��@_p��܊�8H�����T�����+>?ti�*��#�
�X��\�YO荷�U��F�?�F�}��$�TU�b�fiqG:��A�;~�=]���K#ӻ�����m�.�֠i�F�"�ˏ�u�v��/�n��lU�SNTtwN����K�]k�"A�;�-}-^�
�4�����b+�?Ϧ:�b:��i� ���	���>�cz��H��]Օ��j���-y�Ϸ<D�����A�Mp�>��w�Ā�lH�n/���p7sٹAۅ��q@2��<�ϳ��g�&ȡY���'�eq�C}w��5�M�"�Mw�Q×'`�T9v ��(�q�%�J�\����_,8K�,�%��`�
���9��|^�{.1o*��x8+�ׄ<�����#ѭ������_��r8���p8���p8���p8��7�	��m5 (  