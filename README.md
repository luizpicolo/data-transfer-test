# Data Transfer Test

Data Transfer Test is a software developed to measure the amount of data transferred over a period of time.

# Screen

![alt](https://github.com/luizpicolo/data_transfer_test/raw/master/public/images/screen.png)

# How to configure

First clone this repository to the local machine

    git clone https://github.com/luizpicolo/data_transfer_test.git

After, access local respository and install the dependencies 

    cd data_transfer_test
    bundle install

and

    cd data_transfer_test/public
    npm install

# How to use

Create a Task Cron 

    whenever --update-crontab

And, in another terminal, run the `app.rb` and access `localhost:4567`

    ruby app.rb 
or
    
    rerun 'ruby app.rb'
    

## License

DataTransferTest use Licença MIT. For more details read the [User License](./LICENSE.txt)

