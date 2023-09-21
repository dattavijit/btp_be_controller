module.exports.MarkAsObsolete = async function(req) {
    let sReasonComment = req.data.reason;
    const sAssessmentID = req.params[0].ID;

    const { Assessments } = cds.entities('btp.conroller');
    const tx = cds.transaction(req);

    const squery = "CALL SP_MARK_AS_OBSOLETE(IN_ASID => ? ,IN_REASONCOMMENT => ?)";


    const procedureCall = await tx.run(squery, [sAssessmentID, sReasonComment]); 
};

