clear;
clc;

%-------------------------
% Make sure you have all the following files:
    % quanUser.m
    % hadamard.m
    % measure.m
    % generateRandom.m
% Setup
eve_present = 0;
N = 10000; % Length of basis and bits matrices

%-------------------------
alice = quanUser; % Defines Alice as a class quanUser (defined in quanUser.m)
bob = quanUser; % Defines Bob as a class quanUser (defined in quanUser.m)

alice.Basis = generateRandom(N); % Uses generateRandom.m to output a 1xN matrix of 1s and 0s
alice.Bits = generateRandom(N); % Uses generateRandom.m to output a 1xN matrix of 1s and 0s
bob.Basis = generateRandom(N); % Uses generateRandom.m to output a 1xN matrix of 1s and 0s

from_alice = send(alice); % Creates a matrix "from_alice" using the send function defined in the quanUser.m class

fprintf('Successfully sent %.1f photons from Alice.\n',N);

if eve_present
%     fprintf('~Note to user: You have activated Eavesdropper Mode~\n'); % Just for the user to know if they turned on eavesdropping
    eve = quanUser; % Defines Eve as a class quanUser (defined in quanUser.m)
    eve.Basis = generateRandom(N); % Uses generateRandom.m to output a 1xN matrix of 1s and 0s
    eve.Bits = receive(eve, from_alice); % Sets Eve's bits to the output of the receive function defined in the quanUser.m class
    from_alice = send(eve); % Changes the matrix "from_alice" using the send function defined in the quanUser.m class to what Eve is sending to Bob
end

bob.Bits = receive(bob, from_alice); % Sets Bob's bits to the output of the receive function defined in the quanUser.m class

fprintf('Bob has successfully measured %.1f photons.\n',N);

% What percentage was correct
if length(alice.Basis) == length(bob.Basis)
    j = 0;
    for i=1:length(alice.Basis)
        if alice.Bits(i) == bob.Bits(i)
            j = j + 1;
        end
    end
    percent = (j./(length(alice.Basis)))*100;
else
    fprintf('Something went wrong.\n');
end

% Determining whether eavesdropper is present based on the above percentage
if percent > 70
    fprintf('\nNo eavesdropper present. Key is secure.\n(Bob measured %.2f percent correctly.)\n', percent);
else
    fprintf('\nEavesdropper present. Key is not secure.\n(Bob measured %.2f percent correctly.)\n', percent);
end
    

%-------------------------------------------
% % Compare the keys to determine if there is an eavesdropper
% alice_key = [];
% bob_key = [];
% for i=1:N
%     if alice.Basis(i) == bob.Basis(i)
%         alice_key = [alice_key, alice.Bits(i)];
%         bob_key = [bob_key, bob.Bits(i)];
%     end
% end
% 
% if bob_key == alice_key
%     fprintf('Yay!\n');
% else
%     fprintf('Uh oh\n');
% end
