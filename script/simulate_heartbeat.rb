10.times do
  HTTParty.post('http://localhost:3000/gorby')
  sleep(0.1)
end
