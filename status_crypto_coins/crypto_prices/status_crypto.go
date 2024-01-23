package main

import (
  "fmt"
  "io/ioutil"
  "log"
  "net/http"
  "encoding/json"
  "time"
)

type Crypto struct {
  Price float64 `json:"usd"`
}

type Response struct {
  Bitcoin Crypto `json:"bitcoin"`
  Ethereum Crypto `json:"ethereum"`
  Solana Crypto `json:"solana"`
}

func apiCall(url string) []byte {

  response, err := http.Get(url)
    if err != nil {
    log.Fatal(err)
  }

  defer response.Body.Close()
 
  body, err := ioutil.ReadAll(response.Body)
	if err != nil {
		log.Fatal(err)
	}

	return body

}

func processJson(url string) Response {

  response := apiCall(url)
  var processedResponse Response

  err := json.Unmarshal(response, &processedResponse)
  if err != nil {
    log.Fatal(err)
  }

  return processedResponse

}

func main() {

  url := "https://api.coingecko.com/api/v3/simple/price?ids=bitcoin%2Cethereum%2Csolana&vs_currencies=usd"
  response := processJson(url)
  
  update_time := time.Now()
  fmt.Print("| [", update_time.Hour(), ":", update_time.Minute(), ":", update_time.Second(), "] BTC: ", response.Bitcoin.Price, " $ | ETH: ", response.Ethereum.Price, " $ | SOL: ", response.Solana.Price, " $")

}
