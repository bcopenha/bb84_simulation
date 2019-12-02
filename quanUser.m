classdef quanUser
    properties
        Basis
        Bits
    end
    methods
        function qubits = send(obj)
            qubits = [];
            for i=1:length(obj.Basis)
                if obj.Basis(i) == 0
                    if obj.Bits(i) == 0 
                        qubits = [qubits, [1;0]];
                    else
                        qubits = [qubits, [0;1]];
                    end
                else
                    if obj.Bits(i) == 0
                        qubits = [qubits, hadamard([1;0])];
                    else 
                        qubits = [qubits, hadamard([0;1])];
                    end
                end
            end
        end
        function x = receive(obj, received_qubits)
            bits = [];
            for i=1:length(received_qubits)
                if obj.Basis(i) == 0
                    a = {bits,measure(received_qubits(:,i))}; %Could be written as above, like bits = [bits, etc] if I want to clean it up
                    bits = cat(2,a{:});
                else
                    b = {bits, measure(hadamard(received_qubits(:,i)))};
                    bits = cat(2,b{:});
                end
            end
            obj.Bits = bits;
            x = obj.Bits;
        end
    end
end