// SPDX-License-Identifier: MIT
pragma solidity ^0.8.9;

contract OnChainResume {
    struct Resume {
        string name;
        string contactInfo;
        string experience;
        string education;
        string skills;
        bool exists;
    }

    mapping(address => Resume) private resumes;

    event ResumeUpdated(address indexed user, string name);

    function uploadResume(
        string memory _name,
        string memory _contactInfo,
        string memory _experience,
        string memory _education,
        string memory _skills
    ) public {
        resumes[msg.sender] = Resume({
            name: _name,
            contactInfo: _contactInfo,
            experience: _experience,
            education: _education,
            skills: _skills,
            exists: true
        });

        emit ResumeUpdated(msg.sender, _name);
    }

    function viewResume(address _user)
        public
        view
        returns (
            string memory,
            string memory,
            string memory,
            string memory,
            string memory
        )
    {
        require(resumes[_user].exists, "Resume not found");

        Resume memory userResume = resumes[_user];
        return (
            userResume.name,
            userResume.contactInfo,
            userResume.experience,
            userResume.education,
            userResume.skills
        );
    }

    function updateResume(
        string memory _name,
        string memory _contactInfo,
        string memory _experience,
        string memory _education,
        string memory _skills
    ) public {
        require(resumes[msg.sender].exists, "Resume not found");
        resumes[msg.sender] = Resume({
            name: _name,
            contactInfo: _contactInfo,
            experience: _experience,
            education: _education,
            skills: _skills,
            exists: true
        });

        emit ResumeUpdated(msg.sender, _name);
    }
}
