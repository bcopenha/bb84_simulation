clear;
clc;

%-------------------------
%Make sure you have all the following files:
    % quanUser.m
    % hadamard.m
    % measure.m
    %generateRandom.m
%Setup
eve_present = 0;
N = 100; %Length of basis and bits matrices

%-------------------------
alice = quanUser;
bob = quanUser;

alice.Basis = generateRandom(N);
alice.Bits = generateRandom(N);
bob.Basis = generateRandom(N);

from_alice = send(alice);

if eve_present
    fprintf('Eavesdropper mode\n');
    eve = quanUser;
    eve.Basis = generateRandom(N);
    eve.Bits = receive(eve, from_alice);
    from_alice = send(eve);
end

bob.Bits = receive(bob, from_alice); %Sends the class function Bob's basis and the qubit stream from Alice or Eve

%Compare the results to determine if there is an eavesdropper
alice_key = [];
bob_key = [];
for i=1:N
    if alice.Basis(i) == bob.Basis(i)
        alice_key = [alice_key, alice.Bits(i)];
        bob_key = [bob_key, bob.Bits(i)];
    end
end

if bob_key == alice_key
    fprintf('Yay!\n');
else
    fprintf('Uh oh\n');
end

% %What percentage was correct
% if length(alice_key) == length(bob_key)
%     j = 0;
%     for i=1:length(alice_key)
%         if alice_key(i) == bob_key(i)
%             j = j + 1;
%         end
%     end
%     percent = (j./(length(alice_key)))*100
% else
%     fprintf('Something went wrong.');
% end
%       
%What percentage was correct
if length(alice.Basis) == length(bob.Basis)
    j = 0;
    for i=1:length(alice.Basis)
        if alice.Basis(i) == bob.Basis(i)
            j = j + 1;
        end
    end
    percent = (j./(length(alice.Basis)))*100
else
    fprintf('Something went wrong.');
end
  
