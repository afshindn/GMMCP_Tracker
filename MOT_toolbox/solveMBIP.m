function x = solveMBIP(fE,A,b,Aeq,beq,ctype,x0,isFindMax)
try
    options = cplexoptimset();
    if isFindMax
        fE = - fE;
    end
    [x, fval, exitflag, output] = cplexmilp(fE,A,b,Aeq,beq,[],[],[],zeros(size(fE)),[],ctype,x0,options);
    
catch m
    disp(m.message);
end