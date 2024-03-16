while true; do
  price_state=$(~/.config/status_crypto_coins/status_crypto)
  echo $price_state > ~/.config/status_crypto_coins/status_crypto.txt
  sleep 60 
done 

