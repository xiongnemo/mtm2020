/* REXX */
say "I'm thinking of a number between 1 and 10."
secret = RANDOM(1,10)
tries = 1

do while (guess \= secret)
    say "What is your guess?"
    pull guess
    if (DATATYPE(guess,'N')) then
    do
        if (DATATYPE(guess,'W')) then
        do
            if (guess < 0) then
            do
                say "Less than 0."
            end
            if (guess > 10) then
            do
                say "Larger than 10."
            end
        end
        else
            say "Not a whole."
    end
    else
        say "Not a number."
    if (guess \= secret) then
    do
        say "That's not it. Try again"
        tries = tries + 1
    end
end
say "You got it! And it only took you" tries "tries!"
exit
